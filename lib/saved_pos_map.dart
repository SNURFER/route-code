import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class SavedPosMap extends StatefulWidget {
  // 지도 클릭 시 표시할 장소에 대한 마커 목록

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<SavedPosMap> {

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
