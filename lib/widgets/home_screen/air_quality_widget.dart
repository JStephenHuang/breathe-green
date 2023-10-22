import 'package:breathe_green_final/screens/loading.dart';
import 'package:breathe_green_final/services/air_quality.dart';
import 'package:breathe_green_final/services/location.dart';
import 'package:breathe_green_final/services/models.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AirQualityWidget extends StatefulWidget {
  final Function changeScreen;
  const AirQualityWidget({required this.changeScreen, super.key});

  @override
  State<AirQualityWidget> createState() => _AirQualityWidgetState();
}

class _AirQualityWidgetState extends State<AirQualityWidget> {
  void getAirQuality() async {}

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 2 / 2.5,
        child: FutureBuilder<AirQuality?>(
            future: LocationService().getUserAirQuality(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return const LoadingScreen();
              } else if (!snapshot.hasData) {
                return Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                        child: Text(
                      "Enable location permission to view your location's air quality.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )));
              } else if (snapshot.hasData) {
                AirQuality airQuality = snapshot.data!;
                var airQualityIndex = AirQualityService()
                    .airQualityInfoMap[airQuality.list[0].main.aqi]!;
                return Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                    decoration: BoxDecoration(
                      color: airQualityIndex.color.withOpacity(0.5),
                      border: Border.all(
                        color: airQualityIndex.color,
                        width: 2,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: InkWell(
                      onTap: () => widget.changeScreen(1),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.wind,
                              size: 24,
                            ),
                            Text(
                              airQualityIndex.rating.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 24,
                              ),
                            ),
                            const Text(
                              "air quality",
                            ),
                            const Text(
                              "in your region",
                            )
                          ]),
                    ));
              } else {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Something went wrong..."),
                );
              }
            }),
      ),
    );
  }
}
