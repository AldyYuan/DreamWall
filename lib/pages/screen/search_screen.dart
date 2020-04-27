import 'dart:math';

import 'package:dream_wall/api/api.dart';
import 'package:dream_wall/models/pages.dart';
import 'package:dream_wall/models/photos.dart';
import 'package:dream_wall/pages/detail_page.dart';
import 'package:dream_wall/providers/pexels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:dream_wall/services/admob_service.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final _scrollController = ScrollController();
  List<Photos> wallpaper = [];
  var random = Random();
  bool isSearch = false;
  String query;
  bool isLoading = false;
  int _currentPage = 1;
  final ams = AdMobService();

  Future<Pages> loadMore() async {
    if (isLoading == false) {
      setState(() {
        isLoading = true;
        _currentPage++;
      });
    }

    final response =
        await api.get("search?query=$query&per_page=15&page=$_currentPage");
    if (response.statusCode == 200) {
      var tempList = Pages.fromJson(response.data);
      setState(() {
        isLoading = false;
        wallpaper.addAll(tempList.photos);
      });
    }

    return null;
  }

  @override
  void initState() {
    this.loadMore();
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget buildSearchBox() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                        icon: Icon(Icons.search, color: Colors.black),
                        onPressed: () {
                          _focusNode.unfocus();
                          setState(() {
                            isSearch = true;
                          });
                        },
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _controller.clear();
                          _focusNode.unfocus();
                          setState(() {
                            isSearch = false;
                          });
                        },
                        child: const Icon(Icons.clear, color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      hintText: "Search Here e.g Nature"),
                  onChanged: (value) {
                    setState(() {
                      query = value;
                    });
                  },
                  onFieldSubmitted: (value) {
                    _focusNode.unfocus();
                    setState(() {
                      query = value;
                      isSearch = true;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Column(
        children: [
          buildSearchBox(),
          isSearch ? buildSearch() : Container(),
        ],
      )),
    );
  }

  Widget buildSearch() {
    return FutureBuilder<Pages>(
      future: Provider.of<PexelsProvider>(context, listen: false)
          .searchPages(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data.photos.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/not_found.png",
                  width: 250,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "No Data Found",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "No data found, try again with another keyword",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          );
        }

        if (wallpaper.length <= 15) {
          wallpaper.addAll(snapshot.data.photos);
        }
        // Ads
        AdmobBanner(
            adUnitId: ams.getBannerSearch(),
            adSize: AdmobBannerSize.FULL_BANNER);
        return Expanded(
          child: StaggeredGridView.countBuilder(
            physics: const AlwaysScrollableScrollPhysics(),
            crossAxisCount: 4,
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: wallpaper.length,
            itemBuilder: (context, index) {
              final item = wallpaper[index];
              if (index == wallpaper.length) {
                return buildProgressIndicator();
              } else {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (
                        _,
                        __,
                        ___,
                      ) =>
                          DetailPage(photo: item),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ),
                  ),
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: FadeInImage.assetNetwork(
                      image: item.src.medium,
                      placeholder: "assets/loading.gif",
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                );
              }
            },
            staggeredTileBuilder: (index) => StaggeredTile.fit(2),
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
        );
      },
    );
  }
}
