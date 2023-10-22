import 'dart:convert';

import 'package:breathe_green_final/services/location.dart';
import 'package:breathe_green_final/services/models.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

class AirQualityInfo {
  final String rating;
  final Color color;
  AirQualityInfo({required this.color, required this.rating});
}

class InfoCardMap {
  final AirQuality airQuality;
  final Placemark markedLocation;

  InfoCardMap({required this.airQuality, required this.markedLocation});
}

class AirQualityService {
  final Map<int, AirQualityInfo> airQualityInfoMap = {
    1: AirQualityInfo(
      rating: "Good",
      color: Colors.green,
    ),
    2: AirQualityInfo(
      rating: "Fair",
      color: Colors.lime,
    ),
    3: AirQualityInfo(
      rating: "Moderate",
      color: Colors.yellow,
    ),
    4: AirQualityInfo(
      rating: "Poor",
      color: Colors.orange,
    ),
    5: AirQualityInfo(
      rating: "Very poor",
      color: Colors.red,
    ),
  };

  Future<AirQuality> fetchAirQuality(double lat, double lon) async {
    Uri uri = Uri.parse(
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=${const String.fromEnvironment('API_BASE_URL')}");
    Response response = await get(uri);
    if (response.statusCode == 200) {
      return AirQuality.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load air quality');
    }
  }

  Future<InfoCardMap> getInfoCardData(LatLng latLng) async {
    AirQuality airQuality =
        await fetchAirQuality(latLng.latitude, latLng.longitude);
    Placemark markedPlacemark =
        await LocationService().determineLocationFromLatLng(latLng);

    return InfoCardMap(airQuality: airQuality, markedLocation: markedPlacemark);
  }
}
