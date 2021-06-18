import 'dart:async';
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
    Timer(Duration(seconds: 5), () {
      Navigator.pushNamed(context, MyRoutes.homeRoutes);
    });
    //MyNavigator.goToIntro(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: context.theme.buttonColor,
                        radius: 50.0,
                        child: Icon(
                          Icons.games_outlined,
                          //color: Colors.black26,
                          size: 50.0,
                          color: context.theme.cardColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Tic Tac Tie",
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
    );
  }
}
