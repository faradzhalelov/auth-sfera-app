import 'package:dzhalelov_auth/providers/auth_provider.dart';
import 'package:dzhalelov_auth/services/firebase/firebase_auth_service.dart';
import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:dzhalelov_auth/utils/router/route_constants.dart';
import 'package:dzhalelov_auth/widgets/custom_buttom_widget.dart';
import 'package:dzhalelov_auth/widgets/draw_list_widget.dart';
import 'package:dzhalelov_auth/widgets/email_text_field_widget.dart';
import 'package:dzhalelov_auth/widgets/password_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreenWidget extends StatefulWidget {
  const SignUpScreenWidget({Key? key}) : super(key: key);

  @override
  State<SignUpScreenWidget> createState() => _SignUpScreenWidgetState();
}

class _SignUpScreenWidgetState extends State<SignUpScreenWidget> {

  final _key = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _isHiddenPassword = true;

  @override
  void dispose() {
    super.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
  }

  void togglePasswordView() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  _goToHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, homeRoute, (route) => false);
  }

  _goToSignInPage() {
    Navigator.pushNamedAndRemoveUntil(context, signInRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    FirebaseAuthService authService = FirebaseAuthService();

    _register() async {
      final form = _key.currentState;
      if (form!.validate()) {
        form.save();
        dynamic signInResult = await authService.signUp(
            emailTextController.text.trim(),
            passwordTextController.text.trim());
        if (signInResult != null &&
            !signInResult.toString().contains('Exception')) {
          return true;
        } else {
          return false;
        }
      }
      else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).signUp),
      ),
      drawer: const Drawer(
        child: DrawListWidget(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _key,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: Center(
                  child: Text(
                    translation(context).register,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              EmailTextFieldWidget(
                emailTextEditingController: emailTextController,
                validationText: translation(context).unableValidateSignIn,
                hintText: translation(context).email,
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordTextFieldWidget(
                passwordTextEditingController: passwordTextController,
                isHiddenPassword: _isHiddenPassword,
                toggleView: togglePasswordView,
                hintText: translation(context).password,
                validationText: translation(context).minSixNumbers,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtonWidget(
                onPressed: () async {
                  if (await _register()) {
                    auth.signIn();
                    _goToSignInPage();
                  } else {
                    _showAlertDialog(
                        context,
                        translation(context).unableValidateSignIn,
                        translation(context).back,
                        translation(context).authException);
                  }
                },
                text: translation(context).register,
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