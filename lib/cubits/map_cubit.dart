import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCubit extends Cubit<Set<Marker>> {
  MapCubit() : super({}); // Initialize the markers set here

  // Add a method to add a marker to the map
  void addMarker(Marker marker) {
    state.add(marker);
    emit(state);
  }

  // Add a method to remove a marker from the map
  void removeMarker(Marker marker) {
    state.remove(marker);
    emit(state);
  }

  void listenToChanges(void Function(Set<Marker>) listener) {
    stream.listen(listener);
  }
}
