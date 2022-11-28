import 'package:dzhalelov_auth/main.dart';
import 'package:dzhalelov_auth/utils/localization/language.dart';
import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:dzhalelov_auth/utils/theme/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreenWidget extends StatefulWidget {
  const SettingsScreenWidget({Key? key}) : super(key: key);

  @override
  State<SettingsScreenWidget> createState() => _SettingsScreenWidgetState();
}

class _SettingsScreenWidgetState extends State<SettingsScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(translation(context).settings),
          ),
          body: Center(
            child: Column(
              children: <Widget>[
                const Expanded(flex: 1, child: SizedBox(height: 25,)),
                Flexible(
                  flex: 2,
                  child: DropdownButton<Language>(
                    iconSize: 30,
                    hint: Text(translation(context).selectLanguage),
                    onChanged: (Language? language) async {
                      if (language != null) {
                        Locale _locale = await setLocale(
                            language.languageCode);
                        App.setLocale(context, _locale);
                      }
                    },
                    items: Language.languageList()
                        .map<DropdownMenuItem<Language>>(
                          (e) =>
                          DropdownMenuItem<Language>(
                            value: e,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceAround,
                              children: <Widget>[
                                Text(e.name)
                              ],
                            ),
                          ),
                    )
                        .toList(),
                  ),
                ),
                const Expanded(flex: 1, child: SizedBox(height: 10,)),
                Flexible(
                    flex: 1,
                    child: themeNotifier.isDark
                        ? Text(translation(context).darkTheme)
                        : Text(translation(context).lightTheme)
                ),
                Flexible(
                  flex: 1,
                  child: IconButton(
                      icon: Icon(themeNotifier.isDark
                          ? Icons.nightlight_round
                          : Icons.wb_sunny),
                      onPressed: () {
                        themeNotifier.isDark
                            ? themeNotifier.isDark = false
                            : themeNotifier.isDark = true;
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
