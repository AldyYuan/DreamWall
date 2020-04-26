import 'package:dream_wall/pages/home_page.dart';
import 'package:dream_wall/providers/pexels_provider.dart';
import 'package:dream_wall/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onGenerateRoute = (RouteSettings setting) {
      return MaterialPageRoute(
        builder: (context) => route[setting.name],
        settings: setting,
      );
    };

    return ChangeNotifierProvider.value(
      value: PexelsProvider(),
      child: MaterialApp(
        title: 'Dream Wall',
        theme: ThemeData(
          primaryColorBrightness: Brightness.dark,
          primarySwatch: Colors.amber,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
              brightness: Brightness.dark, color: Colors.black, elevation: 0.0),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        home: HomePage(),
      ),
    );
  }
}
