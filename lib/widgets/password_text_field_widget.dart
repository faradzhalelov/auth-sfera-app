import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:flutter/material.dart';

class PasswordTextFieldWidget extends StatefulWidget {
  final TextEditingController passwordTextEditingController;
  final bool isHiddenPassword;
  final Function() toggleView;

  const PasswordTextFieldWidget(
      {Key? key,
        required this.passwordTextEditingController,
        required this.isHiddenPassword,
        required this.toggleView})
      : super(key: key);

  @override
  State<PasswordTextFieldWidget> createState() =>
      _PasswordTextFieldWidgetState();
}

class _PasswordTextFieldWidgetState extends State<PasswordTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: TextFormField(
        maxLines: 1,
        obscureText: widget.isHiddenPassword,
        controller: widget.passwordTextEditingController,
        validator: (password) =>
        password != null && password.length < 6
            ? translation(context).minSixNumbers
            : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: translation(context).password,
            suffix: InkWell(
              onTap: widget.toggleView,
              child: Icon(
                widget.isHiddenPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.black,
              ),
            )),
      ),
    );
  }
}
