import 'package:flutter/material.dart';

class Stat extends StatelessWidget {
  final int quantity;
  final String label;

  const Stat({super.key, required this.quantity, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          quantity.toString(),
          style: const TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
