import 'package:dzhalelov_auth/utils/theme/theme_prefs.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('theme_preferences getTheme test', () async {
    ThemePreferences themePreferences = ThemePreferences();
    expect(await themePreferences.getTheme(), false);
  });

  test('theme_preferences setTheme and getTheme tests', () async {
    ThemePreferences themePreferences = ThemePreferences();
    await themePreferences.setTheme(true);
    expect(await themePreferences.getTheme(), true);
  });

}