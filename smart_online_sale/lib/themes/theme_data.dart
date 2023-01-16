
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_online_sale/utils/constant.dart';

ThemeData themeData() {
  return ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Muli",
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: Colors.black)),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: kTextColor),
      bodyText2: TextStyle(color: kTextColor),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}