import 'package:breathe_green_final/services/auth.dart';
import 'package:breathe_green_final/widgets/forms/custom_text_field.dart';
import 'package:breathe_green_final/widgets/forms/form_button.dart';
import 'package:breathe_green_final/widgets/forms/or_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";

import '../widgets/arrow_left.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool loading = false;
  bool loadingGoogle = false;

  Future<int?> signInWithEmailAndPassword() async {
    setState(() {
      loading = true;
    });
    try {
      await AuthService().signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());
      setState(() {
        loading = false;
      });
      return 200;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code),
        backgroundColor: Colors.red,
      ));
      setState(() {
        loading = false;
      });
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const ArrowLeft(),
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome back!",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Sign in to continue!",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      labelText: "Enter your email",
                      validator: (value) {
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      labelText: "Enter your password",
                      validator: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value.length < 6) {
                          return 'Password too short (6 characters minimum)';
                        }
                        return null;
                      },
                    ),
                    if (loading)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[800],
                            padding: const EdgeInsets.all(16),
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const SizedBox(
                            height: 25.0,
                            width: 25.0,
                            child: Center(
                                child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ),
                    if (!loading)
                      FormButton(
                        label: "LOGIN",
                        onPressFunction: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            signInWithEmailAndPassword().then((value) {
                              if (value == 200) {
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                      ),
                  ],
                ),
              ),
              const OrDivider(),
              if (loadingGoogle)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: SizedBox(
                      height: 25.0,
                      width: 25.0,
                      child: Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.green[800]!,
                      )),
                    ),
                  ),
                ),
              if (!loadingGoogle)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        loadingGoogle = true;
                      });
                      AuthService().googleLogin().then((value) {
                        if (value == 200) {
                          Navigator.pop(context);
                        }
                        setState(() {
                          loadingGoogle = false;
                        });
                      });
                    },
                    icon: const Icon(FontAwesomeIcons.google),
                    label: const Text('SIGN IN WITH GOOGLE',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.green[800],
                      padding: const EdgeInsets.all(16),
                      minimumSize: const Size.fromHeight(50),
                    ),
                  ),
                ),
            ],
          ),
        ),
      )),
    );
  }
}
