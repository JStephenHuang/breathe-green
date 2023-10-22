import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../services/models.dart';
import '../../services/ressource_manager.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Person person = Provider.of<Person>(context);
    User? user = AuthService().user;
    if (user == null) return const CircularProgressIndicator();
    const double radius = 20;
    return CircleAvatar(
      radius: radius + 1,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.white,

        backgroundImage: RessourceManager().getUserAvatar(person.avatar),
        // child: Image(
        //   image: RessourceManager().getUserAvatar(person.avatar),
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
