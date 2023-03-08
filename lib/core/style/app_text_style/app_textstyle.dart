import 'package:flutter/material.dart';

class AppTextStyle {
  static TextStyle labelTextStyle(double size) => TextStyle(
      color: Color.fromARGB(255, 196, 196, 196),
      fontFamily: "Roboto",
      fontSize: size,
      fontWeight: FontWeight.w500);
  static TextStyle grayTextStyle(double size) => TextStyle(
      color: const Color.fromARGB(255, 151, 151, 151),
      fontSize: size,
      fontWeight: FontWeight.w400);
  static TextStyle linkTextStyle(double size, bool enabeled) => TextStyle(
      color: (enabeled)
          ? Color.fromARGB(138, 255, 193, 7)
          : const Color.fromARGB(255, 138, 138, 138),
      fontFamily: "Roboto",
      fontSize: size,
      fontWeight: FontWeight.w400);
}
