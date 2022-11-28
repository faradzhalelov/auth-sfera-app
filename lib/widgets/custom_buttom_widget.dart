import 'package:flutter/material.dart';

class CustomButtonWidget extends StatefulWidget {
  final Function() onPressed;
  final String text;

  const CustomButtonWidget({super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 300,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        child: Text(widget.text),
      ),
    );
  }
}
