import 'dart:async';

import 'package:breathe_green_final/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool errorMessage = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    AuthService().verifyEmail();

    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future<bool> checkEmailVerified() async {
    bool isEmailVerified = await AuthService().checkEmailVerified();

    print("object");

    if (isEmailVerified) {
      timer?.cancel();
      setState(() {
        errorMessage = false;
      });
    }

    return isEmailVerified;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.grey[300]!),
                  ),
                  child: IconButton(
                    onPressed: () => AuthService().signOut(),
                    icon: Icon(FontAwesomeIcons.arrowLeftLong,
                        size: 20, color: Colors.green[800]),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("A verification email has been sent to your email."),
                TextButton(
                    onPressed: () {
                      checkEmailVerified().then((value) {
                        if (value) {
                          setState(() {
                            errorMessage = false;
                          });
                        } else {
                          setState(() {
                            errorMessage = true;
                          });
                        }
                      });
                    },
                    child: const Text("Continue")),
                if (errorMessage) const Text("Email not verified.")
              ],
            ),
          ],
        ),
      )),
    );
  }
}
