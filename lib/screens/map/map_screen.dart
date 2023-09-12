import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_map/config/constatnt.dart';
import 'package:my_map/cubits/map_cubit.dart';
import 'package:my_map/models/position_model.dart';
import 'package:my_map/services/web_socket_service.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class MyMapPage extends StatefulWidget {
  @override
  State<MyMapPage> createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  late WebSocketChannel channel;
  late GoogleMapController _googleMapController;
  late WebSocketService webSocketService;
  @override
  void initState() {
    super.initState();
    webSocketService = WebSocketService();
    channel = webSocketService.connect();
  }

  @override
  Widget build(BuildContext context) {
    final MapCubit mapCubit = BlocProvider.of<MapCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Google Maps')),
        backgroundColor: Colors.amber,
      ),
      body: BlocBuilder<MapCubit, Set<Marker>>(
        builder: (context, markers) {
          return StreamBuilder(
            stream: channel.stream,
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                var position =
                    Position().convertLatLng(snapshot.data as String);
                final newMarkerio = Marker(
                  markerId: MarkerId(DateTime.now().toString()),
                  position: position,
                  infoWindow: InfoWindow(title: 'New Marker'),
                );
                mapCubit.addMarker(newMarkerio);
                _googleMapController.animateCamera(CameraUpdate.newLatLngZoom(
                    LatLng(position.latitude, position.longitude), 14));
              }
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: Constatnt()
                      .defaultLatLng, // Initial map location (San Francisco)
                  zoom: 14.0,
                ),
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _googleMapController = controller;
                },
                onTap: (LatLng latLng) {
                  final newMarker = Marker(
                    markerId: MarkerId(DateTime.now().toString()),
                    position: latLng,
                    infoWindow: InfoWindow(title: 'New Marker'),
                  );
                  mapCubit.addMarker(newMarker); // Add a new marker to the map
                },
              );
            },
          );
        },
      ),
    );
  }
}
