import 'dart:async';
import 'package:flutter_tic_tac_toe/utils/my_navi.dart';
import 'package:flutter_tic_tac_toe/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => MyNavigator.goToHome(context));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: context.theme.buttonColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/tic-tac-toe.png",
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Tic Tac Tie",
                          textScaleFactor: 2.0,
                          style: TextStyle(
                              color: context.theme.accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        color: context.theme.canvasColor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Text(
                        "Lets Play",
                        textScaleFactor: 1.3,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: context.theme.accentColor),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
