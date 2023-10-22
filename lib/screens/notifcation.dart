import 'package:breathe_green_final/widgets/arrow_left.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            ArrowLeft(),
            SizedBox(
              height: 16,
            ),
            Text(
              "Notification feature will be integrated soon... (Under maintenance)",
              textAlign: TextAlign.center,
            )
          ]),
        ),
      ),
    );
  }
}
