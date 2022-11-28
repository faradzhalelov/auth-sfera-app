import 'dart:convert';
import 'package:desktop_webview_auth/google.dart';
import 'package:dzhalelov_auth/credentials/google/google_auth_credentials.dart';
import 'package:dzhalelov_auth/domain/model/user_model.dart';
import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:dzhalelov_auth/utils/router/route_constants.dart';
import 'package:dzhalelov_auth/widgets/custom_buttom_widget.dart';
import 'package:dzhalelov_auth/widgets/draw_list_widget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:desktop_webview_auth/desktop_webview_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


typedef SignInCallback = Future<void> Function();

class SignInGoogleScreenWidget extends StatefulWidget {
  const SignInGoogleScreenWidget({Key? key}) : super(key: key);

  @override
  State<SignInGoogleScreenWidget> createState() =>
      _SignInGoogleScreenWidgetState();
}

class _SignInGoogleScreenWidgetState extends State<SignInGoogleScreenWidget> {

  _goToHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
  }

  _goToEnterPasswordPage() {
    Navigator
        .pushNamedAndRemoveUntil(context,
        enterPasswordGoogleRoute, (route) => false);
  }

  SignInCallback signInWithArgs(
      BuildContext context,
      ProviderArgs args) => () async {
    final result = await DesktopWebviewAuth.signIn(args);
    var token = result?.accessToken;
    if (token != null) {
      final response = await http.get(Uri.parse(googleCredentials + token));
      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(response.body));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', user.email);
        if (prefs.getString('email')!.isNotEmpty
            && prefs.getString('email')!.contains('@')) {
          _goToEnterPasswordPage();
        }
        else {
          if(!mounted) return;
          _showAlertDialog(
              context,
              translation(context).alert,
              translation(context).back,
              translation(context).signInGoogle);
        }
      }
    }
  };

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).signInGoogle),
      ),
      drawer: const Drawer(
        child: DrawListWidget(),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Expanded(flex: 1, child: SizedBox(height: 50,)),
            Flexible(
              flex: 2,
              child: CustomButtonWidget(
                onPressed:
                  signInWithArgs(context, GoogleSignInArgs(
                      clientId: googleClientId,
                      redirectUri: redirectURL,
                      scope: googleScopes),
                  ),
                text: translation(context).signInGoogle,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButtonWidget(
              onPressed: _goToHomePage,
              text: translation(context).homePage,
            ),
          ],
        ),
      ),
    );
  }

}

_showAlertDialog(
    BuildContext context,
    String message,
    String buttonName,
    String alertName) {
  // Create button
  Widget exitButton = TextButton(
    child: Text(buttonName),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(alertName),
    content: Text(message),
    actions: [
      exitButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}