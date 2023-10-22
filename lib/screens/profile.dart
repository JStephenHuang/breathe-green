import 'package:breathe_green_final/screens/garden.dart';
import 'package:breathe_green_final/screens/leaderboards.dart';
import 'package:breathe_green_final/screens/loading.dart';
import 'package:breathe_green_final/services/firestore.dart';
import 'package:breathe_green_final/services/models.dart';
import 'package:breathe_green_final/widgets/profile_screen/circle_stats.dart';
import 'package:breathe_green_final/widgets/profile_screen/circular_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/auth.dart';
import '../services/date_time.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = AuthService().user;

    if (user == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      return const Scaffold(
        body: Text("User not logged in."),
      );
    }
    Size size = MediaQuery.of(context).size;
    bool isSmallPhone = size.width <= 320;
    return Expanded(
      child: ListView(
        children: [
          Column(
            children: [
              const Text(
                "YOUR STATS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Swipe left on the circle to check your points.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const CircleStats(),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircularButton(
                    icon: FontAwesomeIcons.chartSimple,
                    page: LeaderboardsScreen(),
                  ),
                  CircularButton(
                    icon: FontAwesomeIcons.tree,
                    page: GardenScreen(),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Click the left or right button to see more data.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                  future: FirestoreService().getTreesFromCurrentUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingScreen();
                    }
                    if (snapshot.hasData) {
                      List<Tree>? userTrees = snapshot.data;

                      if (userTrees == null) return Container();

                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: isSmallPhone ? 25 : 35),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "You've pinned a total of ${userTrees.length} trees.",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800),
                                ),
                                if (userTrees.isEmpty)
                                  const Text("No pinned trees.")
                                else
                                  Text(
                                      "Last tree pinned on ${DateTimeService().formatDateTime(userTrees[userTrees.length - 1].date)}")
                              ]),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  })
            ],
          ),
        ],
      ),
    );
  }
}
