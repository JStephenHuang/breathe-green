import 'package:breathe_green_final/screens/loading.dart';
import 'package:breathe_green_final/services/firestore.dart';
import 'package:breathe_green_final/widgets/user_trees_screen/tree_widget.dart';
import 'package:flutter/material.dart';

import '../services/models.dart';
import '../widgets/arrow_left.dart';

class ListOfTrees extends StatelessWidget {
  const ListOfTrees({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().getTreesFromCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }
          if (snapshot.hasData) {
            List<Tree>? trees = snapshot.data;
            if (trees == null) return Container();
            return ListView(
              children: trees
                  .map((tree) => TreeWidget(
                        tree: tree,
                      ))
                  .toList(),
            );
          } else {
            return Container();
          }
        });
  }
}

class UserTreesScreen extends StatelessWidget {
  const UserTreesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            ArrowLeft(),
            SizedBox(
              height: 16,
            ),
            Text(
              "YOUR TREES",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(child: ListOfTrees())
          ]),
        ),
      ),
    );
  }
}
