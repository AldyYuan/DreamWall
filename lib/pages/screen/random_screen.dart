import 'dart:math';

import 'package:dream_wall/api/api.dart';
import 'package:dream_wall/models/pages.dart';
import 'package:dream_wall/models/photos.dart';
import 'package:dream_wall/pages/detail_page.dart';
import 'package:dream_wall/providers/pexels_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:dream_wall/services/admob_service.dart';

class RandomScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  List<Photos> wallpaper = [];
  bool isLoading = false;
  final _scrollController = ScrollController();
  var random = Random();
  final ams = AdMobService();

  Future<Pages> loadMore() async {
    if (isLoading == false) {
      setState(() {
        isLoading = true;        
      });
    }

    var other = random.nextInt(1000);
    final response = await api.get("curated?per_page=15&page=$other");
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
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Randoms",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          FutureBuilder<Pages>(
            future:
                Provider.of<PexelsProvider>(context, listen: false).getOther(random.nextInt(1000)),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (wallpaper.length <= 15) {
                wallpaper.addAll(snapshot.data.photos);
              }
              // Ads
              AdmobBanner(
                adUnitId: ams.getBannerRandom(), adSize: AdmobBannerSize.FULL_BANNER
              );
              return Expanded(
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                            image: item.src.original,
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
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
