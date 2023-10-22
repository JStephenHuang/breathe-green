import 'package:breathe_green_final/screens/loading.dart';
import 'package:breathe_green_final/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class PinnedTreesWidget extends StatelessWidget {
  final Function changeScreen;
  const PinnedTreesWidget({required this.changeScreen, super.key});

  @override
  Widget build(BuildContext context) {
    User? user = AuthService().user;
    if (user == null) return const CircularProgressIndicator();
    return Expanded(
      child: AspectRatio(
        aspectRatio: 2 / 1.5,
        child: FutureBuilder(
          future: FirestoreService().getTreesFromCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            }
            if (snapshot.connectionState == ConnectionState.none) {
              return const Text("Something went wrong");
            }
            if (snapshot.hasData) {
              return Container(
                  margin: const EdgeInsets.fromLTRB(6, 12, 0, 0),
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
                        const Text(
                          "You have",
                        ),
                        Text(
                          snapshot.data!.length.toString(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          "pinned trees",
                        ),
                      ],
                    ),
                  ));
            } else {
              return const Text("No values.");
            }
          },
        ),
      ),
    );
  }
}
