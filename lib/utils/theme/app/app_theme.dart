import 'package:flutter/material.dart';

import '../theme_model.dart';

class AppColors {
  BuildContext context;
  ThemeModel themeModel;

  AppColors({required this.context, required this.themeModel});

  static const Color darkRussianViolet = Color.fromRGBO(51, 0, 54, 1.0);
  static const Color darkDarkPurple = Color.fromRGBO(56, 24, 47, 1.0);
  static const Color darkCharcoal = Color.fromRGBO(47, 57, 77, 1.0);
  static const Color darkCadet = Color.fromRGBO(86, 102, 107, 1.0);
  static const Color darkLemonMeringue = Color.fromRGBO(238, 225, 179, 1.0);


  static const Color lightRussianViolet = Color.fromRGBO(11, 60, 73, 1.0);
  static const Color lightDarkPurple = Color.fromRGBO(115, 25, 99, 1.0);
  static const Color lightCharcoal = Color.fromRGBO(255, 253, 253, 1.0);
  static const Color lightCadet = Color.fromRGBO(203, 210, 208, 1.0);
  static const Color lightLemonMeringue = Color.fromRGBO(240, 225, 0, 1.0);

  static const Color backgroundColor = Colors.white;

  setAuthBackColor() {
    return themeModel.isDark ? Colors.blueGrey.withOpacity(0.5) : Colors.cyan.withOpacity(0.5);
  }

  setBackColor() {
    return themeModel.isDark ? Colors.grey : Colors.white;
  }

  setBoxContainerColor() {
    return themeModel.isDark ? darkCharcoal : lightCharcoal;
  }

  setTextFieldColor() {
    return themeModel.isDark ? darkCadet : lightCadet;
  }

  setBottomColor() {
    return themeModel.isDark ? darkLemonMeringue : lightLemonMeringue;
  }

}