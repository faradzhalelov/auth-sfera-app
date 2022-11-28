import 'package:dzhalelov_auth/utils/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeThemeIconButton extends StatelessWidget {
  const ChangeThemeIconButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (
        context, ThemeModel themeNotifier, child) {
      return IconButton(onPressed: () {
        themeNotifier.isDark
            ? themeNotifier.isDark = false
            : themeNotifier.isDark = true;
      }, icon: Icon(themeNotifier.isDark
          ? Icons.nightlight_round
          : Icons.wb_sunny));
    },);
  }
}