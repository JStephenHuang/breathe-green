import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BottomNavItem extends StatelessWidget {
  const BottomNavItem(
      {required this.icon,
      required this.label,
      required this.currentIndex,
      required this.index,
      required this.changeScreen,
      super.key});

  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final Function changeScreen;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool smallPhone = size.width <= 320;
    Color color =
        currentIndex == index ? Colors.green[800]! : const Color(0xffDDDDDD);

    return MaterialButton(
        minWidth: smallPhone ? 70 : 90,
        onPressed: () => changeScreen(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: smallPhone ? 20 : 30,
              color: color,
            ),
            // Text(
            //   label,
            //   style: TextStyle(color: color),
            // ),
          ],
        ));
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav(
      {required this.changeScreen, required this.currentIndex, super.key});

  final Function changeScreen;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool smallPhone = size.width <= 320;

    return BottomAppBar(
      child: Container(
        height: smallPhone ? 60 : 70,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                BottomNavItem(
                  icon: IconlyBold.home,
                  label: "Home",
                  changeScreen: changeScreen,
                  currentIndex: currentIndex,
                  index: 0,
                ),
                BottomNavItem(
                  icon: IconlyBold.discovery,
                  label: "Air quality",
                  changeScreen: changeScreen,
                  currentIndex: currentIndex,
                  index: 1,
                ),
              ],
            ),
            Row(
              children: [
                BottomNavItem(
                  icon: IconlyBold.profile,
                  label: "Profile",
                  changeScreen: changeScreen,
                  currentIndex: currentIndex,
                  index: 2,
                ),
                BottomNavItem(
                  icon: IconlyBold.setting,
                  label: "Setting",
                  changeScreen: changeScreen,
                  currentIndex: currentIndex,
                  index: 3,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
