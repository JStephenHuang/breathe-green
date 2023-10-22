import 'package:breathe_green_final/screens/loading.dart';
import 'package:breathe_green_final/services/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        child: FutureBuilder<Map<MarkerId, Marker>?>(
            future: FirestoreService().getPinnedTreesMarkersFromCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingScreen();
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Container();
              } else {
                if (snapshot.hasData && snapshot.data == null) {
                  return Container();
                } else if (snapshot.hasData) {
                  void onMapCreated(GoogleMapController controller) {
                    mapController = controller;
                  }

                  return GoogleMap(
                      scrollGesturesEnabled: true,
                      gestureRecognizers: <Factory<
                          OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      onMapCreated: onMapCreated,
                      myLocationEnabled: true,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(45.51, -73.67),
                        zoom: 9.8,
                      ),
                      markers: Set<Marker>.of(snapshot.data!.values));
                } else {
                  return Container();
                }
              }
            }));
  }
}
