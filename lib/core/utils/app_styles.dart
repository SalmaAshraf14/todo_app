
import 'package:flutter/material.dart';

import 'colors_manager.dart';


class AppLightStyles {
  static TextStyle appBarTextStyle =TextStyle(
      fontSize: 22, fontWeight: FontWeight.w700, color: ColorsManager.white);
  static TextStyle? bottomSheetTitle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: ColorsManager.blackAccent);
  static TextStyle? hintStyle =TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: ColorsManager.grey);
  static TextStyle? dateLabel = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: ColorsManager.blackAccent);
  static TextStyle? dateStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w400, color: ColorsManager.grey);
  static TextStyle? tasksTitle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w700, color: ColorsManager.blue);
  static TextStyle? taskDesc = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: ColorsManager.blackAccent);
  static TextStyle? taskDate = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: ColorsManager.blackAccent);

}