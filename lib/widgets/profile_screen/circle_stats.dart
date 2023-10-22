import 'package:breathe_green_final/screens/loading.dart';
import 'package:breathe_green_final/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:breathe_green_final/widgets/profile_screen/stat.dart';
import 'package:provider/provider.dart';

import '../../services/auth.dart';
import '../../services/models.dart';

class CircleStats extends StatefulWidget {
  const CircleStats({super.key});

  @override
  State<CircleStats> createState() => _CircleStatsState();
}

class _CircleStatsState extends State<CircleStats> {
  final PageController _pageController = PageController(initialPage: 0);
  int _activePage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool smallPhone = size.width <= 320;

    Person person = Provider.of<Person>(context);
    User? user = AuthService().user;

    if (user == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      return const Scaffold(
        body: Text("User not logged in."),
      );
    }

    return Container(
      padding: const EdgeInsets.all(20),
      width: smallPhone ? 200 : 250,
      height: smallPhone ? 200 : 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(125),
        image: const DecorationImage(
          image: AssetImage("assets/pinned_tree_bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page;
                });
              },
              children: [
                FutureBuilder(
                    future: FirestoreService().getTreesFromCurrentUser(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        const LoadingScreen();
                      }
                      if (snapshot.hasData) {
                        return Stat(
                            quantity: snapshot.data!.length,
                            label: "PINNED TREES");
                      } else {
                        return Container();
                      }
                    })),
                Stat(quantity: person.points, label: "POINTS"),
              ],
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  2,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () {
                            _pageController.animateToPage(index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          },
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: _activePage == index
                                ? Colors.green
                                : Colors.white,
                          ),
                        ),
                      )))
        ],
      ),
    );
  }
}
