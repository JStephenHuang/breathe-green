import 'package:breathe_green_final/screens/congradulation.dart';
import 'package:breathe_green_final/screens/landing.dart';
import 'package:breathe_green_final/screens/auth.dart';
import 'package:breathe_green_final/screens/login.dart';
import 'package:breathe_green_final/screens/notifcation.dart';
import 'package:breathe_green_final/screens/pin_a_tree.dart';
import 'package:breathe_green_final/screens/register.dart';
import 'package:breathe_green_final/screens/user_trees.dart';

var appRoutes = {
  "/": (context) => const LandingScreen(),
  "/auth": (context) => const AuthScreen(),
  "/pin-a-tree": (context) => const PinATreeScreen(),
  "/login": (context) => const LoginScreen(),
  "/register": (context) => const RegisterScreen(),
  "/congradulation": (context) => const CongradulationScreen(),
  "/notification": (context) => const NotificationScreen(),
  "/user-trees": (context) => const UserTreesScreen(),
};
