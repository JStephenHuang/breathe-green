import 'package:breathe_green_final/services/ressource_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/models.dart';

class LeaderboardProfile extends StatelessWidget {
  final Person person;
  final int index;

  const LeaderboardProfile(
      {required this.person, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  "${index + 1}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )),
            Expanded(
              flex: 2,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 25,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        RessourceManager().getUserAvatar(person.avatar),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                person.name,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${person.points}",
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      FontAwesomeIcons.leaf,
                      size: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
