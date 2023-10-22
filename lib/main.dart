import 'package:breathe_green_final/services/firebase_messaging.dart';
import 'package:breathe_green_final/services/firestore.dart';
import 'package:breathe_green_final/services/models.dart';
import 'package:breathe_green_final/theme.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import "package:breathe_green_final/routes.dart";

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessagingService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (_) => FirestoreService().streamPerson(),
      initialData: Person(
        uid: "n/a",
        name: "n/a",
        email: "n/a",
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routes: appRoutes,
      ),
    );
  }
}
