import 'dart:developer';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_intigration/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  // PolylinePoints polylinePoints = PolylinePoints();

  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

//   // Starting point latitude
//   double _originLatitude = 21.7080427;
// // Starting point longitude
//   double _originLongitude = 72.9956936;
// // Destination latitude
//   double _destLatitude = 21.2050293;
// // Destination Longitude
//   double _destLongitude = 72.9956936;

  // Map<PolylineId, Polyline> polylines = {};

  GoogleMapController? mapController;

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final LatLng center = const LatLng(23.0216238, 72.5797068);
  List<Marker> markers = [];

  final Set<Polyline> polyline = {};

  List<LatLng> latlng = [
    const LatLng(23.013004799999997, 72.50611957304073),
    const LatLng(23.0271, 72.508)
  ];

//23.0271 , 72.508
  addMarker() {
    // Marker firstMarker = Marker(
    //   markerId: const MarkerId(' Jodhpur'),
    //   position: const LatLng(26.275682850000003, 73.02969731064445),
    //   infoWindow: const InfoWindow(
    //       title: 'Jodhpur', snippet: 'Major city of Rajasthan'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    // );
    // Marker secondMarker = Marker(
    //   markerId: const MarkerId('Bharuch'),
    //   position: const LatLng(21.7080427, 72.9956936),
    //   infoWindow: const InfoWindow(title: 'Bharuch'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    // );
    // Marker thirdMarker = Marker(
    //   markerId: const MarkerId('Surat'),
    //   position: const LatLng(21.2050293, 72.8407427),
    //   infoWindow: const InfoWindow(title: 'Surat', snippet: 'Smart City'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    // );
    Marker fourthMarker = Marker(
      markerId: const MarkerId('Ahmedabad'),
      position: center,
      infoWindow: const InfoWindow(
          title: 'Ahmedabad', snippet: 'This is initial position'),
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
    );

    notifyListeners();

    markers.add(fourthMarker);

    notifyListeners();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  //for current location
  void getCurrentLocation() async {
    //update the camera position when current location is getting...
    Position position = await determinePosition();
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 14)));

    //show marker..

    // markers.add(
    //   Marker(
    //       markerId: const MarkerId('CurrentLocation'),
    //       position: LatLng(position.latitude, position.longitude),
    //       infoWindow: const InfoWindow(title: 'Your current location')),
    // );
    notifyListeners();
  }

  //polyLines
  // void getPolyline() async {
  //   List<LatLng> polylineCoordinates = [];

  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     'AIzaSyA-GTK1Ir0flJ3bUBwOLaIUfTy4wwdLsTs',
  //     PointLatLng(_originLatitude, _originLongitude),
  //     PointLatLng(_destLatitude, _destLongitude),
  //     travelMode: TravelMode.driving,
  //   );
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   } else {
  //     print(result.errorMessage);
  //   }
  //   _addPolyLine(polylineCoordinates);
  //   notifyListeners();
  // }

  // _addPolyLine(List<LatLng> polylineCoordinates) {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //     polylineId: id,
  //     color: Colors.blueAccent,
  //     points: polylineCoordinates,
  //     width: 8,
  //   );
  //   polylines[id] = polyline;
  //   notifyListeners();
  // }

  addPolyline() {
    for (var i = 0; i < latlng.length; i++) {
      if (i % 2 == 0) {
        markers.add(Marker(
          markerId: const MarkerId('Iskon'),
          position: latlng[1],
          // infoWindow: const InfoWindow(title: 'Iskon'),
          onTap: () {
            customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/img2.jfif'),
                              fit: BoxFit.fitWidth,
                              filterQuality: FilterQuality.high),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 30, 53, 31),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Iskcon Radha Govinda Temple',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            RatingBarIndicator(
                                rating: 2.75,
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                itemCount: 5,
                                itemSize: 10.0,
                                direction: Axis.horizontal)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 20),
                        child: const Text(
                            'Sri Sri Radha Govinda, #Iskcon Temple #Tirupati Radha Krishna Images, Radhe Krishna. PurePrayer ... 21 Amazing Pictures of Lord Narasimha the Lion Avatar.',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 75, 74, 74))),
                      )
                    ],
                  ),
                ),
                latlng[1]);
            // notifyListeners();
          },
          //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        ));
      } else {
        markers.add(Marker(
          markerId: const MarkerId('PralhadNagar'),
          position: latlng[0],
          onTap: () {
            log('tap on pralhadnagar');

            customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/img.jfif'),
                              fit: BoxFit.fitWidth,
                              filterQuality: FilterQuality.high),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Color.fromARGB(255, 30, 53, 31),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            const Text(
                              'Prahlad Nagar Garden',
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                            const SizedBox(
                              width: 80,
                            ),
                            RatingBarIndicator(
                                rating: 2.75,
                                itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                itemCount: 5,
                                itemSize: 10.0,
                                direction: Axis.horizontal)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 20),
                        child: const Text(
                            'Prahaladnagar is pretty close to SG Highway where the most hip food joints are these days. This is a fairly good garden with a walking track.',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 75, 74, 74))),
                      )
                    ],
                  ),
                ),
                latlng[0]);
            // notifyListeners();
          },
          // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        ));
      }

      polyline.add(
        Polyline(
          polylineId: const PolylineId('1'),
          points: latlng,
          color: Colors.blue,
        ),
      );

      notifyListeners();
    }
    notifyListeners();
  }
}
