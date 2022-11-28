import 'package:dzhalelov_auth/utils/localization/language_constants.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailTextFieldWidget extends StatefulWidget {
  final TextEditingController emailTextEditingController;

  const EmailTextFieldWidget({
    Key? key,
    required this.emailTextEditingController}) : super(key: key);

  @override
  State<EmailTextFieldWidget> createState() => _EmailTextFieldWidgetState();
}

class _EmailTextFieldWidgetState extends State<EmailTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        maxLines: 1,
        controller: widget.emailTextEditingController,
        validator: (email) =>
        email != null && !EmailValidator.validate(email)
            ? translation(context).unableValidateSignIn
            : null,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: translation(context).email),
      ),
    );
  }
}
