import 'package:flutter/material.dart';

import '../../services/location.dart';

class LocationPermission extends StatefulWidget {
  const LocationPermission({super.key});

  @override
  State<LocationPermission> createState() => _LocationPermissionState();
}

class _LocationPermissionState extends State<LocationPermission> {
  Future<bool> _locationPermission = LocationService().getLocationPermission();

  void requestLocationPermission() async {
    setState(() {
      _locationPermission = LocationService().requestLocationPermission();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _locationPermission,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Container();
        } else {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Location services:",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Text(
                    snapshot.data! ? "ENABLED" : "DISABLED",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: snapshot.data! ? Colors.green : Colors.red,
                    ),
                  )),
                ],
              ),
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}
