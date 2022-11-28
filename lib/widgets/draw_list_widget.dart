import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:dzhalelov_auth/utils/router/route_constants.dart';
import 'package:flutter/material.dart';

class DrawListWidget extends StatefulWidget {
  const DrawListWidget({Key? key}) : super(key: key);

  @override
  State<DrawListWidget> createState() => _DrawListWidgetState();
}

class _DrawListWidgetState extends State<DrawListWidget> {
  final TextStyle _textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 24,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: SizedBox(
              height: 100,
              child: CircleAvatar(),
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