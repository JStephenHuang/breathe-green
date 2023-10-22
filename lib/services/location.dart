import 'package:breathe_green_final/services/air_quality.dart';
import 'package:breathe_green_final/services/models.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  Future<AirQuality?> getUserAirQuality() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    Position position = await Geolocator.getCurrentPosition();

    return await AirQualityService()
        .fetchAirQuality(position.latitude, position.longitude);
  }

  Future<bool> requestLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever ||
          permission == LocationPermission.unableToDetermine) {
        return false;
      }
    }

    return true;
  }

  Future<bool> getLocationPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      return false;
    }

    return true;
  }

  Future<Position?> determinePosition() async {
    bool locationPermission = await requestLocationPermission();

    if (!locationPermission) return null;

    return await Geolocator.getCurrentPosition();

    // Test if location services are enabled.
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
  }

  Future<Placemark> determineLocationFromLatLng(LatLng latLng) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    Placemark place = placemarks[0];

    return place;
  }
}
