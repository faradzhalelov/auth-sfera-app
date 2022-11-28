import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:flutter/material.dart';


class NotFoundScreenWidget extends StatelessWidget {
  const NotFoundScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).offline),
      ),
      body: const Center(
        child: Text('404'),
      ),
    );
  }
}
