import 'dart:io';

class AdMobService {
  String getAdMobAppId() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1543914617867163~3408455609';
    } else {
      return null;
    }
  }

  String getBannerHome() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1543914617867163/1488869274';
    } else {
      return null;
    }
  }

  String getBannerSearch() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1543914617867163/6358052578';
    } else {
      return null;
    }
  }

  String getBannerRandom() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1543914617867163/6166480885';
    } else {
      return null;
    }
  }

  String getBannerDetail() {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1543914617867163/3348745854';
    } else {
      return null;
    }
  }
}
