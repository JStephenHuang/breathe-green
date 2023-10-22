import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  const CustomTextField(
      {required this.controller,
      required this.labelText,
      required this.validator,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        cursorColor: Colors.green[800],
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(width: 10),
          ),
          labelText: labelText,
          floatingLabelStyle: TextStyle(color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),

        controller: controller,
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          validator;
          return null;
        },
      ),
    );
  }
}
