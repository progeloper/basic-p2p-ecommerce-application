import 'package:flutter/material.dart';

import '../constants/colors.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool isFocused;
  bool obscureText;
  TextInputType keyboardType;
  TextFieldWidget({Key? key, required this.isFocused,required this.controller, required this.hintText, this.obscureText = false, this.keyboardType = TextInputType.text}) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    bool isFocused = false;

    return  Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          (widget.isFocused == true)
              ? BoxShadow(
            color: amazonOrange.withOpacity(0.6),
            blurRadius: 8,
            spreadRadius: 2,
          )
              : BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            borderSide: BorderSide.none,
          ),
          fillColor: textFieldBackground,
          filled: true,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: textFieldLabel,
          ),
        ),
      ),
    );
  }
}
