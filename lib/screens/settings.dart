import 'package:breathe_green_final/widgets/setting_screen/credentials.dart';
import 'package:breathe_green_final/widgets/setting_screen/location_permission.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "SETTINGS",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Credentials(),
                  const LocationPermission(),
                  const SizedBox(height: 20),
                  TextButton.icon(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      label: const Text(
                        'Sign Out',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.red,
                            fontSize: 20),
                      ),
                      icon: const Icon(
                        FontAwesomeIcons.rightFromBracket,
                        size: 18,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        await AuthService().signOut();
                        // ignore: use_build_context_synchronously
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/', (route) => false);
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
