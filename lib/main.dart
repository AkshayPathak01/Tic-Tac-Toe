import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/pages/home_pages.dart';
import 'package:flutter_tic_tac_toe/pages/splash_screen.dart';
import 'package:flutter_tic_tac_toe/themes/themes.dart';
import 'package:flutter_tic_tac_toe/utils/routes.dart';

void main() {
  runApp(MyApp());
}

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => HomePage(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MyTheme.lightTheme(context),
      // use system ,dark ,light
      darkTheme: MyTheme.darkTheme(context),
      home: SplashScreen(),
      routes: routes,
    );
  }
}
