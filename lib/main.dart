import 'package:dream_wall/pages/home_page.dart';
import 'package:dream_wall/utils/routes.dart';
import 'package:flutter/material.dart';

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
    
    return MaterialApp(
      title: 'Dream Wall',
      theme: ThemeData(
        primaryColorBrightness: Brightness.dark,
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: AppBarTheme(
            brightness: Brightness.dark, color: Colors.black, elevation: 0.0),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      home: HomePage(),
    );
  }
}
