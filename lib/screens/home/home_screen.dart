import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:dzhalelov_auth/utils/router/route_constants.dart';
import 'package:dzhalelov_auth/widgets/custom_buttom_widget.dart';
import 'package:dzhalelov_auth/widgets/draw_list_widget.dart';
import 'package:flutter/material.dart';


class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({Key? key}) : super(key: key);

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
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

  _goToSignGooglePage() {
    Navigator.pushNamed(context, signInGoogleRoute);
  }

  _goToSignInPage() {
    Navigator.pushNamed(context, signInRoute);
  }

  _goToSignUpPage() {
    Navigator.pushNamed(context, signUpRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).homePage),
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
                    translation(context).signIn,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtonWidget(
                onPressed: _goToSignInPage,
                text: translation(context).signIn,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtonWidget(
                onPressed: _goToSignGooglePage,
                text: translation(context).signInGoogle,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButtonWidget(
                onPressed: _goToSignUpPage,
                text: translation(context).signUp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _drawerList() {
    TextStyle _textStyle = const TextStyle(
      color: Colors.white,
      fontSize: 24,
    );
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(
              height: 100,
              child: const CircleAvatar(),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 30,
            ),
            title: Text(
              translation(context).settings,
              style: _textStyle,
            ),
            onTap: () {
              // To close the Drawer
              Navigator.pop(context);
              // Navigating to About Page
              Navigator.pushNamed(context, settingsRoute);
            },
          ),
        ],
      ),
    );
  }
}

