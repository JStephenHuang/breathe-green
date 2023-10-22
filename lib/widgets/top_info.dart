import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../services/models.dart';
import 'home_screen/avatar_widget.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({required this.changeScreen, super.key});
  final Function changeScreen;

  @override
  Widget build(BuildContext context) {
    User? user = AuthService().user;
    if (user == null) return const CircularProgressIndicator();
    Person person = Provider.of<Person>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () => changeScreen(3),
              child: Row(
                children: [
                  const AvatarWidget(),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      person.name,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, "/user-trees"),
                icon: const Icon(
                  IconlyLight.activity,
                  size: 30,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
