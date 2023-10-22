import 'package:breathe_green_final/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';
import '../services/models.dart';
import '../services/ressource_manager.dart';

class AvatarGrid extends StatelessWidget {
  final AvatarObject avatarObject;
  const AvatarGrid({required this.avatarObject, super.key});

  @override
  Widget build(BuildContext context) {
    var person = Provider.of<Person>(context);
    bool enoughPoints = person.points >= avatarObject.requiredPoints;

    void updateAvatar() async {
      if (enoughPoints) {
        await FirestoreService().updateAvatar(avatarObject.lvl);
      } else {
        showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('Not enough points.'),
                  content: const Text(
                      "You don't have enough points to select that avatar."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Understood'),
                    ),
                  ],
                ));
      }
    }

    return InkWell(
      onTap: updateAvatar,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: enoughPoints
            ? Image(
                image: avatarObject.avatar,
              )
            : Stack(
                children: [
                  Container(
                    color: Colors.black,
                  ),
                  Image(
                    image: avatarObject.avatar,
                    opacity: const AlwaysStoppedAnimation(.7),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        Text(
                          avatarObject.requiredPoints.toString(),
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          FontAwesomeIcons.leaf,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class GardenScreen extends StatelessWidget {
  const GardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var person = Provider.of<Person>(context);
    var user = AuthService().user;

    if (user == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      return const Scaffold(
        body: Text("User not logged in."),
      );
    }

    Size size = MediaQuery.of(context).size;
    bool isSmallPhone = size.width <= 320;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "YOUR GARDEN",
                textAlign: TextAlign.center,
                style: TextStyle(
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: isSmallPhone ? 50 : 70,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              backgroundImage: RessourceManager().getUserAvatar(person.avatar),
              radius: isSmallPhone ? 49 : 69,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You have ${person.points}",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 5),
              const Icon(FontAwesomeIcons.leaf)
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: GridView.count(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                children: RessourceManager()
                    .getAvatars()
                    .map((avatar) => AvatarGrid(avatarObject: avatar))
                    .toList()),
          ),
        ],
      ),
    );
  }
}
