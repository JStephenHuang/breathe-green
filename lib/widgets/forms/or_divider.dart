import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Divider(
          color: Colors.black,
          thickness: 1,
        )),
        SizedBox(
          width: 5,
        ),
        Text("or"),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Divider(
          color: Colors.black,
          thickness: 1,
        )),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}
