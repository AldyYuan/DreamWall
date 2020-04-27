import 'package:dream_wall/models/pages.dart';
import 'package:dream_wall/models/photos.dart';
import 'package:dream_wall/providers/pexels_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:dream_wall/services/admob_service.dart';

class DetailPage extends StatefulWidget {
  final Photos photo;

  const DetailPage({Key key, this.photo}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Photos> wallpaper = [];
  String selected;
  List<String> src = [
    "Original",
    "Large2x",
    "Large",
    "Medium",
    "Small",
    "Potrait",
    "Landscape",
    "Tiny"
  ];
  String url;

  var random = Random();
  final ams = AdMobService();

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Stack(
          children: [
            ListView(
              children: [
                _getPhotos(context, widget.photo),
                _buildDescription(widget.photo),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Other Images",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                FutureBuilder<Pages>(
                  future: Provider.of<PexelsProvider>(context, listen: false)
                      .getOther(random.nextInt(1000)),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // Ads
                    AdmobBanner(
                        adUnitId: ams.getBannerDetail(),
                        adSize: AdmobBannerSize.FULL_BANNER);
                    wallpaper.addAll(snapshot.data.photos);
                    return Expanded(
                      child: StaggeredGridView.countBuilder(
                        physics: ClampingScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        itemCount: wallpaper.length,
                        itemBuilder: (context, index) {
                          final item = wallpaper[index];
                          return GestureDetector(
                            onTap: () => Navigator.pushReplacement(
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
                        },
                        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                      ),
                    );
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _getToolbar(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPhotos(BuildContext context, Photos item) {
    return Column(
      children: [
        FadeInImage.assetNetwork(
          image: item.src.original,
          placeholder: "assets/loading.gif",
        ),
      ],
    );
  }

  Widget _getToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: RawMaterialButton(
        elevation: 2,
        fillColor: Colors.amber[50],
        child: Icon(Icons.arrow_back),
        padding: EdgeInsets.all(12),
        shape: CircleBorder(),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildDescription(Photos item) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text("Photo by ${item.photographer} on Pexels"),
            subtitle: FlatButton(
              child: Text("Visit Photographer"),
              onPressed: () {
                _launchUrl(item.photographerUrl);
              },
              color: Colors.amber[100],
            ),
            trailing: FlatButton(
                child: Image.asset("assets/pexels.png"),
                onPressed: () {
                  _launchUrl(item.url);
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: FlatButton.icon(
                  color: Colors.greenAccent[400],
                  onPressed: () async {
                    try {
                      var imageId = await ImageDownloader.downloadImage(
                          item.src.original);
                      if (imageId == null) {
                        return;
                      }

                      var fileName = await ImageDownloader.findName(imageId);
                      scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Download $fileName Success"),
                        ),
                      );
                    } on PlatformException catch (error) {
                      print(error);
                    }
                  },
                  icon: Icon(Icons.file_download, color: Colors.white),
                  label:
                      Text("Download", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
