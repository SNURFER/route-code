import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapWidget2 extends StatefulWidget {
  LatLng pos;
  MapWidget2({required this.pos});

  @override
  _MapWidgetState createState() => _MapWidgetState(pos: this.pos);
}

class _MapWidgetState extends State<MapWidget2> {
  LatLng pos;
  _MapWidgetState({required this.pos});

  Completer<GoogleMapController> _mapController = Completer();

  LatLng _camPosition = LatLng(37, 127);
  // late LatLng _center;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
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
          markers: {
            Marker(
              markerId: MarkerId('검색 위치'),
              position: pos,
              infoWindow: InfoWindow(title: '검색 위치'),
            ),
          },
        ),
      ),
    );
  }
}
