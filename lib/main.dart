import 'package:dzhalelov_auth/credentials/firebase/firebase_auth_credentials.dart';
import 'package:dzhalelov_auth/domain/model/user_model.dart';
import 'package:dzhalelov_auth/providers/auth_provider.dart';
import 'package:dzhalelov_auth/providers/user_provider.dart';
import 'package:dzhalelov_auth/screens/auth/sign_in_screen.dart';
import 'package:dzhalelov_auth/screens/auth/sign_out_screen.dart';
import 'package:dzhalelov_auth/screens/error/not_found_screen.dart';
import 'package:dzhalelov_auth/screens/home/home_screen.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/firebase/firebase_auth_service.dart';
import 'services/user_preferences.dart';
import 'utils/localization/language_constants.dart';
import 'utils/router/custom_router.dart';
import 'utils/router/route_constants.dart';
import 'utils/theme/theme_model.dart';

void main() {
  FirebaseAuth.initialize(firebaseApiKey, VolatileStore());
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _AppState? state = context.findAncestorStateOfType<_AppState>();
    state?.setLocale(newLocale);
  }

}

class _AppState extends State<App> {
  Locale? _locale;
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
  Future<User> getUserData () => UserPreferences().getUser();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
          return MaterialApp(
            title: 'SФERA',
            debugShowCheckedModeBanner: false,
            theme: themeSetter(themeNotifier),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            onGenerateRoute: CustomRouter.generatedRoute,
            home: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return const NotFoundScreenWidget();
                    } else if(snapshot.data!.email.isEmpty) {
                      return const HomeScreenWidget();
                    } else {
                      Provider.of<UserProvider>(context).setUser(snapshot.data!);
                    }
                    return const SignOutScreenWidget();
                }
              },
            ),
            locale: _locale,
          );
        },
      ),
    );
  }

  ThemeData? themeSetter(ThemeModel themeNotifier) {
    return themeNotifier.isDark
        ? ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.blueGrey
    )
        : ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.cyan,
        primarySwatch: Colors.cyan
    );
  }

}
