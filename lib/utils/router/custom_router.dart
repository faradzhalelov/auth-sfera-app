import 'package:dzhalelov_auth/screens/auth/enter_password_google_screen.dart';
import 'package:dzhalelov_auth/screens/auth/sign_in_google_screen.dart';
import 'package:dzhalelov_auth/screens/auth/sign_in_screen.dart';
import 'package:dzhalelov_auth/screens/auth/sign_out_screen.dart';
import 'package:dzhalelov_auth/screens/auth/sign_up_screen.dart';
import 'package:dzhalelov_auth/screens/error/not_found_screen.dart';
import 'package:dzhalelov_auth/screens/home/home_screen.dart';
import 'package:dzhalelov_auth/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'route_constants.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreenWidget());
      case signOutRoute:
        return MaterialPageRoute(builder: (_) => const SignOutScreenWidget());
      case signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreenWidget());
      case signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreenWidget());
      case signInGoogleRoute:
        return MaterialPageRoute(builder: (_) =>
        const SignInGoogleScreenWidget());
      case enterPasswordGoogleRoute:
        return MaterialPageRoute(builder: (_) =>
        const EnterPasswordGoogleScreenWidget());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsScreenWidget());
      default:
        return MaterialPageRoute(builder: (_) => const NotFoundScreenWidget());
    }
  }
}
