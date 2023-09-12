import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_map/screens/map/map_screen.dart';
import 'cubits/map_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Map',
      home: BlocProvider(
        create: (context) => MapCubit(), // Provide your Cubit instance
        child: MyMapPage(),
      ),
    );
  }
}
