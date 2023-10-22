import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../services/models.dart';

class PointsWidget extends StatelessWidget {
  final Function changeScreen;
  const PointsWidget({required this.changeScreen, super.key});

  @override
  Widget build(BuildContext context) {
    Person person = Provider.of<Person>(context);
    User? user = AuthService().user;
    if (user == null) return const CircularProgressIndicator();
    return Expanded(
        child: AspectRatio(
      aspectRatio: 2 / 2.5,
      child: Container(
        margin: const EdgeInsets.fromLTRB(6, 0, 0, 0),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          border: Border.all(
            color: Colors.green[800]!,
            width: 2,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: InkWell(
          onTap: () => changeScreen(2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                FontAwesomeIcons.leaf,
                size: 24,
              ),
              const Text(
                "you have",
              ),
              Text(
                person.points.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              const Text(
                "seeds",
              )
            ],
          ),
        ),
      ),
    ));
  }
}
