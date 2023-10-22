import 'package:breathe_green_final/screens/loading.dart';
import 'package:breathe_green_final/services/firestore.dart';
import 'package:breathe_green_final/services/models.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_screen/leaderboard_profile.dart';

class People extends StatelessWidget {
  const People({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person>>(
      future: FirestoreService().getLeaderboard(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(snapshot.error.toString()),
            ),
          );
        } else if (snapshot.hasData) {
          List<Person> persons = snapshot.data!;
          return ListView(
            children: persons
                .map((person) => LeaderboardProfile(
                    person: person, index: persons.indexOf(person)))
                .toList(),
          );
        } else {
          return const Text('No person found in Firestore. Check database');
        }
      },
    );
  }
}

class LeaderboardsScreen extends StatelessWidget {
  const LeaderboardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "LEADERBOARDS",
                textAlign: TextAlign.center,
                style: TextStyle(
                  backgroundColor: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Rank",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    "Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    "Points",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: People(),
            )
          ],
        ),
      ),
    );
  }
}
