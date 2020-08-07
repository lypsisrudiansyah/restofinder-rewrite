//* Constant Color
import 'package:flutter/material.dart';

Color primaryColor = Color(0xffFF8554);
Color primarySwatch = Color(0xffFF8554);

//* Device size
double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}