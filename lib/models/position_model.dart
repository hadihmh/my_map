import 'package:google_maps_flutter/google_maps_flutter.dart';

class Position {
  final LatLng? latLng;

  Position({
    this.latLng,
  });

  LatLng convertLatLng(String latLng) {
    return LatLng(
        double.parse(latLng.split(",")[0]), double.parse(latLng.split(",")[1]));
  }
}
