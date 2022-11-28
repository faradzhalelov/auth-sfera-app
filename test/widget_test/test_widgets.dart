import 'package:dzhalelov_auth/screens/auth/sign_in_screen.dart';
import 'package:dzhalelov_auth/widgets/custom_buttom_widget.dart';
import 'package:dzhalelov_auth/widgets/draw_list_widget.dart';
import 'package:dzhalelov_auth/widgets/email_text_field_widget.dart';
import 'package:dzhalelov_auth/widgets/password_text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Password Text Editing Widget test', (tester) async {
    // Create the widget by telling the tester to build it.
    bool isHiddenPassword = true;
    TextEditingController editingController = TextEditingController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PasswordTextFieldWidget(
          passwordTextEditingController: editingController,
              isHiddenPassword: isHiddenPassword,
              toggleView: () { }, hintText: 'PasswordHintText', validationText: 'PasswordValidationText',),
      ),
    ));

    final hintText = find.text('PasswordHintText');

    expect(hintText, findsOneWidget);
  });


  testWidgets('Email Text Editing Widget test', (tester) async {
    // Create the widget by telling the tester to build it.
    TextEditingController editingController = TextEditingController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: EmailTextFieldWidget(
          emailTextEditingController: editingController,
          hintText: 'EmailHintText', validationText: 'EmailValidationText',),
      ),
    ));

    final hintText = find.text('EmailHintText');

    expect(hintText, findsWidgets);
  });

  testWidgets('Custom Button Widget test', (tester) async {
    // Create the widget by telling the tester to build it.
    TextEditingController editingController = TextEditingController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomButtonWidget(
          onPressed: () {  },
          text: 'ButtonText',
        ),
      ),
    ));

    final buttonText = find.text('ButtonText');

    expect(buttonText, findsOneWidget);

  });
  
  testWidgets('drawList test', (widgetTester) async {
    await widgetTester.pumpWidget(
        const MaterialApp(
            home: Scaffold(
              drawer: Drawer(
                child: DrawListWidget(),
              ),
            ),
        ),
    );
  });


}