import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapWidget3 extends StatefulWidget {
  // 지도 클릭 시 표시할 장소에 대한 마커 목록

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget3> {

  final List<Marker> markers = [];

  Completer<GoogleMapController> _mapController = Completer();

  LatLng _camPosition = LatLng(37.3, 127.3);
  // late LatLng _center;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();

    int markerNum = 10;

    for (int i = 0; i < markerNum; i++) {
      Random rng = Random();
      double ranLat = (rng.nextDouble() - 0.5) * 3 + _camPosition.latitude;
      double ranLng = (rng.nextDouble() - 0.5) * 3 + _camPosition.longitude;
      this.markers.add(Marker(
        markerId: MarkerId("Test"),
        position: LatLng(ranLat, ranLng),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('루트코드'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
            controller.showMarkerInfoWindow(MarkerId('검색 위치'));
          },
          initialCameraPosition: CameraPosition(
            target: _camPosition,
            zoom: 6.0,
          ),
          markers: markers.toSet(),
        ),
      ),
    );
  }
}
//
// class MapWidget3 extends StatefulWidget {
//   @override
//   _MapWidgetState createState() => _MapWidgetState();
// }
//
// class _MapWidgetState extends State<MapWidget3> {
//   late GoogleMapController _mapController;
//   LatLng _center = LatLng(37.5070, 127.0586);
//   LatLng _camPosition = LatLng(37, 127);
//   // late LatLng _center;
//   late Position _currentPosition;
//
//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _mapController = controller;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   void _getCurrentLocation() async {
//     Geolocator.requestPermission();
//     //TODO) handling dismiss is needed
//     _currentPosition = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//
//     print(_currentPosition.longitude);
//     print(_currentPosition.latitude);
//
//     setState(() {
//       _center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
//       _mapController.animateCamera(CameraUpdate.newLatLngZoom(_center, 14));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('루트코드'),
//           backgroundColor: Colors.green[700],
//         ),
//         body: _center == null
//             ? Center(child: CircularProgressIndicator())
//             :GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: _camPosition,
//             zoom: 6.0,
//           ),
//           markers: {
//             Marker(
//               markerId: MarkerId('현재 위치'),
//               position: _center,
//               infoWindow: InfoWindow(title: '현재 위치'),
//             ),
//           },
//         ),
//       ),
//     );
//   }
// }
