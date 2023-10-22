import 'package:breathe_green_final/widgets/air_quality_screen/info_card.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/air_quality.dart';

class AirQualityScreen extends StatefulWidget {
  const AirQualityScreen({super.key});

  @override
  State<AirQualityScreen> createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  String markerLocation = "No location marked";

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  double infoCardPosition = -230;
  Future<InfoCardMap>? infoCardMapFuture;

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void addMarker(LatLng latLng) async {
    final lat = latLng.latitude;
    final lon = latLng.longitude;

    print(latLng);

    if (markers.isNotEmpty) {
      setState(() {
        infoCardPosition = -230;
      });
      markers.clear();
      return;
    }

    final MarkerId markerId = MarkerId("$lat,$lon");

    final Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      onTap: () {
        markers.remove(markerId);
      },
    );

    setState(() {
      infoCardMapFuture = AirQualityService().getInfoCardData(latLng);
      markers[markerId] = marker;
      infoCardPosition = 0;
    });

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
              lat,
              lon,
            ),
            zoom: 11),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              "AIR QUALITY",
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
              "Click anywhere on the map to check the air quality.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      child: GoogleMap(
                        onMapCreated: _onMapCreated,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(45.508888, -73.561668),
                          zoom: 10.0,
                        ),
                        myLocationEnabled: true,
                        onTap: addMarker,
                        markers: Set<Marker>.of(markers.values),
                      )),
                  if (infoCardMapFuture != null)
                    InfoCard(
                      infoCardMapFuture: infoCardMapFuture!,
                      infoCardPosition: infoCardPosition,
                    )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            )
          ],
        ),
      ),
    );
  }
}
