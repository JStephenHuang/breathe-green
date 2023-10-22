import 'package:breathe_green_final/services/firestore.dart';
import 'package:breathe_green_final/widgets/home_screen/air_quality_widget.dart';
import 'package:breathe_green_final/widgets/home_screen/daily_pinned_trees_widget.dart';
import 'package:breathe_green_final/widgets/home_screen/map_widget.dart';
import 'package:breathe_green_final/widgets/home_screen/pinned_trees_widget.dart';
import 'package:breathe_green_final/widgets/home_screen/points_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.changeScreen, super.key});
  final Function changeScreen;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    FirestoreService().verifyAndResetDailyLimit();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = AuthService().user;
    if (user == null) return const CircularProgressIndicator();
    Size size = MediaQuery.of(context).size;
    bool smallPhone = size.width <= 320;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const Text(
              "HOME",
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
              "Summary",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                AirQualityWidget(changeScreen: widget.changeScreen),
                PointsWidget(changeScreen: widget.changeScreen)
              ],
            ),
            Row(
              children: [
                const DailyPinnedTreesWidget(),
                PinnedTreesWidget(changeScreen: widget.changeScreen),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Pinned trees",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              height: smallPhone ? 350 : 500,
              child: const MapWidget(),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
