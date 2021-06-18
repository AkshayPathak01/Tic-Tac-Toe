import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/pages/splash_screen.dart';
import 'package:flutter_tic_tac_toe/themes/themes.dart';
import 'package:flutter_tic_tac_toe/utils/routes.dart';

void main() {
  runApp(MyApp());
}

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
        routes: {
          MyRoutes.splashRoutes: (context) =>
              SplashScreen(), 
               MyRoutes.homeRoutes: (context) =>
              SplashScreen(), // "/" by default screen of app
        // "/" by default screen of app
        });
  }
}
