import 'package:dzhalelov_auth/domain/model/user_model.dart';
import 'package:dzhalelov_auth/providers/auth_provider.dart';
import 'package:dzhalelov_auth/providers/user_provider.dart';
import 'package:dzhalelov_auth/services/firebase/firebase_auth_service.dart';
import 'package:dzhalelov_auth/services/user_preferences.dart';
import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:dzhalelov_auth/utils/router/route_constants.dart';
import 'package:dzhalelov_auth/widgets/custom_buttom_widget.dart';
import 'package:dzhalelov_auth/widgets/draw_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignOutScreenWidget extends StatefulWidget {
  const SignOutScreenWidget({Key? key}) : super(key: key);

  @override
  State<SignOutScreenWidget> createState() => _SignOutScreenWidgetState();
}

class _SignOutScreenWidgetState extends State<SignOutScreenWidget> {

  _goToHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    FirebaseAuthService authService = FirebaseAuthService();
    UserPreferences userPreferences = UserPreferences();

    _loginOut() async {
      authService.signOut();
      auth.signOut();
    }

    User user = Provider
        .of<UserProvider>(context)
        .user;
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).signOut),
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
                onPressed: () {
                  try {
                    UserPreferences().removeUser();
                    _loginOut();
                    _goToHomePage();
                  } catch (e) {
                    _showAlertDialog(context,
                        translation(context).alert,
                        translation(context).signOut,
                        translation(context).signOut);
                  }
                },
                text: translation(context).signOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_showAlertDialog(BuildContext context, String message, String buttonName,
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