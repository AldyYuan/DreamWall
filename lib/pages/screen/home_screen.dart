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

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Photos> wallpaper = [];
  bool isLoading = false;
  int _currentPage = 1;
  final _scrollController = ScrollController();
  final ams = AdMobService();

  Future<Pages> loadMore() async {
    if (isLoading == false) {
      setState(() {
        isLoading = true;
        _currentPage++;
      });
    }

    final response = await api.get("curated?per_page=50&page=$_currentPage");
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
    _scrollController.dispose();
    super.dispose();
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ads
          AdmobBanner(
              adUnitId: ams.getBannerHome(),
              adSize: AdmobBannerSize.FULL_BANNER),
          Divider(thickness: 1),
          FutureBuilder<Pages>(
            future:
                Provider.of<PexelsProvider>(context, listen: false).getPhotos(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (wallpaper.length <= 15) {
                wallpaper.addAll(snapshot.data.photos);
              }

              return Expanded(
                child: StaggeredGridView.countBuilder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  crossAxisCount: 4,
                  itemCount: wallpaper.length,
                  controller: _scrollController,
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
                            transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) =>
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
          ),
        ],
      ),
    );
  }
}
