import 'package:breathe_green_final/screens/auth.dart';
import 'package:breathe_green_final/screens/email_verification.dart';
import 'package:breathe_green_final/screens/settings.dart';
import 'package:breathe_green_final/services/auth.dart';
import 'package:breathe_green_final/screens/profile.dart';
import 'package:breathe_green_final/widgets/bottom_nav.dart';
import 'package:breathe_green_final/widgets/top_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:breathe_green_final/screens/air_quality.dart';
import 'package:breathe_green_final/screens/home.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentIndex = 0;

  changeScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(changeScreen: changeScreen),
      const AirQualityScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];

    return StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            if (user == null) return const Text("User is null");
            if (!user.emailVerified) {
              return const EmailVerificationScreen();
            }
            Size size = MediaQuery.of(context).size;
            bool smallPhone = size.width <= 320;
            return Scaffold(
              backgroundColor: Colors.white,
              bottomNavigationBar: BottomNav(
                changeScreen: changeScreen,
                currentIndex: currentIndex,
              ),
              floatingActionButton: Container(
                margin: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                height: smallPhone ? 60 : 70,
                width: smallPhone ? 60 : 70,
                child: FloatingActionButton(
                  onPressed: () => Navigator.pushNamed(context, "/pin-a-tree"),
                  backgroundColor: Colors.green[800],
                  tooltip: "Pin a tree",
                  child: Icon(
                    FontAwesomeIcons.locationDot,
                    size: smallPhone ? 30 : 35,
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              body: SafeArea(
                  child: Column(
                children: [
                  TopInfo(
                    changeScreen: changeScreen,
                  ),
                  screens[currentIndex],
                ],
              )),
            );
          } else {
            return const AuthScreen();
          }
        });
  }
}
