import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../screens/loading.dart';
import '../../services/auth.dart';
import '../../services/firestore.dart';
import '../../services/models.dart';

class DailyPinnedTreesWidget extends StatelessWidget {
  const DailyPinnedTreesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = AuthService().user;
    if (user == null) return const CircularProgressIndicator();

    final Map<int, Color?> colorIndex = {
      0: Colors.green,
      1: Colors.green,
      2: Colors.yellow,
      3: Colors.red,
    };

    return Expanded(
      child: AspectRatio(
        aspectRatio: 2 / 1.5,
        child: GestureDetector(
            child: FutureBuilder(
          future: FirestoreService().getPerson(user.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text("Something went wrong");
            }
            if (snapshot.hasData) {
              Person? person = snapshot.data;
              if (person == null) return Container();

              return Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 6, 0),
                  decoration: BoxDecoration(
                    color: colorIndex[person.dailyPinnedTreeCount]!
                        .withOpacity(0.5),
                    border: Border.all(
                      color: colorIndex[person.dailyPinnedTreeCount]!,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, "/user-trees"),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${person.dailyPinnedTreeCount.toString()}/3",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "daily pinned trees",
                        ),
                      ],
                    ),
                  ));
            } else {
              return const Text("No values.");
            }
          },
        )),
      ),
    );
  }
}
