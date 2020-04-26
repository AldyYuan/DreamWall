import 'package:dream_wall/pages/home_page.dart';
import 'package:dream_wall/providers/pexels_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

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
        home: HomePage(),
      ),
    );
  }
}
