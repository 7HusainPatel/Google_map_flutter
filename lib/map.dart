import 'dart:developer';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_intigration/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //Location _location = Location();
  //Location currrentlocation = Location();
  final LatLng _center = const LatLng(23.0216238, 72.5797068);

  // late GoogleMapController mapController;
  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

  //Set<Marker> _markers = {};
  //List<Marker> markers = [];
  @override
  void initState() {
    super.initState();
    // var myight = MediaQuery.of(context).size.height *10;
    final ofProvider = Provider.of<MapProvider>(context, listen: false);
    ofProvider.addMarker();
    ofProvider.addPolyline();

    //ofProvider.getPolyline();
    // Marker firstMarker = Marker(
    //   markerId: const MarkerId(' Jodhpur'),
    //   position: const LatLng(26.275682850000003, 73.02969731064445),
    //   infoWindow: const InfoWindow(title: 'Jodhpur'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    // );
    // Marker secondMarker = Marker(
    //   markerId: const MarkerId('Bharuch'),
    //   position: const LatLng(26.9154576, 75.8189817),
    //   infoWindow: const InfoWindow(title: 'Bharuch'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    // );
    // Marker thirdMarker = Marker(
    //   markerId: const MarkerId('Surat'),
    //   position: const LatLng(21.2050293, 72.8407427),
    //   infoWindow: const InfoWindow(title: 'Surat'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    // );
    // Marker fourthMarker = Marker(
    //   markerId: const MarkerId('Mumbai'),
    //   position: const LatLng(18.9733536, 72.82810491917377),
    //   infoWindow: const InfoWindow(title: 'Mumbai'),
    //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    // );
    // //assihn to the list..
    // setState(() {
    //   markers.add(firstMarker);
    //   markers.add(secondMarker);
    //   markers.add(thirdMarker);
    //   markers.add(fourthMarker);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, value, child) {
        //final ofProvider = Provider.of<MapProvider>(context);
        //  value.addMarker();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Map Screen'),
            backgroundColor: Colors.deepPurple[300],
          ),
          body: Stack(
            children: [
              GoogleMap(
                padding: const EdgeInsets.only(bottom: 60),

                zoomControlsEnabled: true,
                // polylines: Set<Polyline>.of(value.polylines.values),
                markers: value.markers.map((e) => e).toSet(),
                onMapCreated: (controller) {
                  value.onMapCreated(controller);
                  value.customInfoWindowController.googleMapController =
                      controller;
                },
                initialCameraPosition:
                    CameraPosition(target: value.center, zoom: 11.0),
                myLocationEnabled: true,
                polylines: value.polyline,
                onTap: (position) {
                  value.customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  value.customInfoWindowController.onCameraMove!();
                },
              ),
              CustomInfoWindow(
                controller: value.customInfoWindowController,
                height: 200,
                width: 300,
                offset: 50,
              )
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(right: 40),
            child: FloatingActionButton(
              onPressed: () async {
                log('Updating location');
                // _updatePosition();
                // getLocation();
                value.getCurrentLocation();
              },
              tooltip: 'Get Current Location',
              backgroundColor: Colors.deepPurple,
              child: const Icon(Icons.location_searching),
            ),
          ),
        );
      },
    );
  }

  //...............................get user current Location..................................
  /// Determine the current position of the device.
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  // static Future<Position> detō
  // void getCurrentLocation() async {
  //   //update the camera position when current location is getting...
  //   Position position = await determinePosition();
  //   mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //       target: LatLng(position.latitude, position.longitude), zoom: 14)));
  //   //show marker..
  //   setState(() {
  //     markers.add(Marker(
  //         markerId: const MarkerId('CurrentLocation'),
  //         position: LatLng(position.latitude, position.longitude)));
  //   });
  //   log('Latitude-->${position.latitude}');
  //   log('Longitude-->${position.longitude}');
  // }
  // void _updatePosition() {
  //   _location.onLocationChanged.listen((l) {
  //     mapController.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
  //     ));
  //   });
  // }
  // void getLocation() async {
  //   var location = await currrentlocation.getLocation();
  //   currrentlocation.onLocationChanged.listen((LocationData loc) {
  //     mapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //           target: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
  //           zoom: 12.0,
  //         ),
  //       ),
  //     );
  //     log('Latitude-->${loc.latitude}');
  //     log('Longitude-->${loc.longitude}');
  //     setState(() {
  //       _markers.add(Marker(
  //           markerId: MarkerId('Home'),
  //           position: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0)));
  //     });
  //   });
  // }
}
//https://rrtutors.com/tutorials/show-multiple-markers-on-google-maps-flutter
