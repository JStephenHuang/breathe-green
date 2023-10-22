import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final void Function() onPressFunction;
  final String label;
  const FormButton(
      {required this.onPressFunction, required this.label, super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: onPressFunction,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[800],
          padding: const EdgeInsets.all(16),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
