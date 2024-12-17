
import 'package:flutter/material.dart';

import 'colors_manager.dart';


class AppLightStyles {
  static const TextStyle appBarTextStyle = TextStyle(
      fontSize: 22, fontWeight: FontWeight.w700, color: ColorsManager.white);
  static const TextStyle? bottomSheetTitle = TextStyle(
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
  static TextStyle? calenderSelectedItem = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: ColorsManager.blue);
  static TextStyle? calenderUnSelectedItem = TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, color: ColorsManager.black);
  static TextStyle? title = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w500, color: ColorsManager.white);
  static TextStyle? hint = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
      color: ColorsManager.black.withOpacity(0.7));
  static TextStyle? buttonTitle = TextStyle(
      fontSize: 14, fontWeight: FontWeight.w600, color: Colors.blue.shade900);
  static TextStyle? edite = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w700, color: ColorsManager.black);
}
