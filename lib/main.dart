import 'package:flutter/material.dart';
import 'package:google_map_intigration/provider.dart';
import 'package:provider/provider.dart';

import 'map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MapProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MapScreen(),
      ),
    );
  }
}
//https://www.youtube.com/watch?v=Zlzq8gKr5sA&t=109s....https://codelabs.developers.google.com/codelabs/google-maps-in-flutter#4...........https://www.youtube.com/watch?v=YwjqXqId2EM.............
//https://www.maps.ie/coordinates.html