import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../services/models.dart';

class Credential extends StatelessWidget {
  final String label;
  final String value;
  const Credential({required this.label, required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Credentials extends StatefulWidget {
  const Credentials({super.key});

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  @override
  Widget build(BuildContext context) {
    Person person = Provider.of<Person>(context);
    User? user = AuthService().user;

    if (user == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      return const Scaffold(
        body: Text("User not logged in."),
      );
    }

    return Column(
      children: [
        Credential(label: "Name:", value: person.name),
        Credential(label: "Email:", value: person.email),
        Credential(label: "Uid:", value: person.uid),
      ],
    );
  }
}
