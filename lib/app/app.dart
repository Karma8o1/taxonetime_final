// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:taxonetime/main.dart';
import 'package:taxonetime/screens/onBoard/onBoardingPage.dart';
import 'package:taxonetime/screens/wrapper/wrapper.dart';
import 'package:taxonetime/themes.dart';

DateTime _lastExitTime = DateTime.now();

class TaxOneTime extends StatelessWidget {
  TaxOneTime({Key? key, required this.isviewed}) : super(key: key);
  bool isviewed;
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: MyThemes.darkTheme,
      builder: (context, myTheme) {
        return GetMaterialApp(
          // turn it false before publishing
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.deepOrange,
            fontFamily: 'Roboto',
            textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 36.0),
              headline2: TextStyle(fontSize: 28.0),
              headline3: TextStyle(fontSize: 24.0),
              headline4: TextStyle(fontSize: 20.0),
              headline5: TextStyle(fontSize: 18.0),
              headline6: TextStyle(fontSize: 14.0),
              bodyText1: TextStyle(fontSize: 12.0),
              bodyText2: TextStyle(fontSize: 10.0),
            ),
          ),
          home: isviewed ? const Wrapper() : (const OnBoardingPage()),
        );
      },
    );
  }
}
