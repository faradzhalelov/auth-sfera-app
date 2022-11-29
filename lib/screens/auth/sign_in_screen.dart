import 'package:dzhalelov_auth/providers/auth_provider.dart';
import 'package:dzhalelov_auth/services/firebase/firebase_auth_service.dart';
import 'package:dzhalelov_auth/services/user_preferences.dart';
import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:dzhalelov_auth/utils/router/route_constants.dart';
import 'package:dzhalelov_auth/utils/theme/app/app_styles.dart';
import 'package:dzhalelov_auth/utils/theme/app/app_theme.dart';
import 'package:dzhalelov_auth/utils/theme/theme_model.dart';
import 'package:dzhalelov_auth/widgets/custom_buttom_widget.dart';
import 'package:dzhalelov_auth/widgets/draw_list_widget.dart';
import 'package:dzhalelov_auth/widgets/email_text_field_widget.dart';
import 'package:dzhalelov_auth/widgets/password_text_field_widget.dart';
import 'package:dzhalelov_auth/widgets/responsive_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/model/user_model.dart';

class SignInScreenWidget extends StatefulWidget {
  const SignInScreenWidget({Key? key}) : super(key: key);

  @override
  State<SignInScreenWidget> createState() => _SignInScreenWidgetState();
}

class _SignInScreenWidgetState extends State<SignInScreenWidget> {
  final _key = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  bool _isHiddenPassword = true;

  User get user => User(
      email: emailTextController.text.trim(),
      isVerifiedEmail: true,
      picture: '',
      id: '',
      token: ''
  );

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

  _goToSignOutPage() {
    Navigator.pushNamedAndRemoveUntil(context, signOutRoute, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    ThemeModel themeModel = Provider.of<ThemeModel>(context);
    FirebaseAuthService authService = FirebaseAuthService();
    UserPreferences userPreferences = UserPreferences();

    login() async {
      final form = _key.currentState;
      if (form!.validate()) {
        form.save();
        dynamic signInResult = await authService.signIn(
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

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors(
        context: context,
        themeModel: themeModel,).setBackColor(),
      appBar: AppBar(
        title: Text(translation(context).signIn),
        actions: [
          IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                _goToHomePage();
              }),
        ],
      ),
      drawer: const Drawer(
        child: DrawListWidget(),
      ),
      body: Form(
        key: _key,
        child: SizedBox(
          height: height,
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ResponsiveWidget.isSmallScreen(context)
                  ? const SizedBox()
                  : Expanded(
                child: Container(
                  color: AppColors(context: context, themeModel: themeModel).setBackColor(),
                  height: height,
                  child: Center(
                    child: Text(
                      'AuthSfera',
                      style: ralewayStyle.copyWith(
                        fontSize: 48.0,
                        color: AppColors(
                            context: context,
                            themeModel: themeModel).setTextFieldColor(),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: height,
                  margin: EdgeInsets.symmetric(
                      horizontal:
                  ResponsiveWidget.isSmallScreen(context)
                      ? height * 0.032 : height * 0.012),
                  color: AppColors(
                      context: context,
                      themeModel: themeModel).setAuthBackColor(),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.2,),
                        RichText(text: TextSpan(
                            children: [
                              TextSpan(
                                  text: translation(context).signIn,
                                  style: ralewayStyle.copyWith(
                                    fontSize: 25.0,
                                    color: AppColors.backgroundColor,
                                    fontWeight: FontWeight.normal,
                                  ),),
                            ])),
                        const SizedBox(height: 6.0),
                        EmailTextFieldWidget(
                          emailTextEditingController: emailTextController,
                          validationText: translation(context).unableValidateSignIn,
                          hintText: translation(context).email,
                        ),
                        const SizedBox(height: 6.0),
                        PasswordTextFieldWidget(
                          passwordTextEditingController: passwordTextController,
                          isHiddenPassword: _isHiddenPassword,
                          toggleView: togglePasswordView,
                          hintText: translation(context).password,
                          validationText: translation(context).minSixNumbers,
                        ),
                    SizedBox(height: height * 0.05),
                        CustomButtonWidget(
                          onPressed: () async {
                            if (await login()) {
                              auth.signIn();
                              userPreferences.saveUser(user);
                              _goToSignOutPage();
                            } else {
                              _showAlertDialog(
                                  context,
                                  translation(context).unableValidateSignIn,
                                  translation(context).back,
                                  translation(context).authException);
                            }
                          },
                          text: translation(context).signIn,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
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
