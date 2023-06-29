import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MapWidget extends StatefulWidget {

  @override
  _MapWidgetState createState() => _MapWidgetState();

}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _mapController;
  LatLng _center = LatLng(37.5070, 127.0586);
  LatLng _camPosition = LatLng(37, 127);
  // late LatLng _center;
  late Position _currentPosition;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    Geolocator.requestPermission();
    //TODO) handling dismiss is needed
    _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(_currentPosition.longitude);
    print(_currentPosition.latitude);

    setState(() {
      _center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(_center, 14));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _center == null
            ? Center(child: CircularProgressIndicator())
            :GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _camPosition,
            zoom: 6.0,
          ),
          markers: {
            Marker(
              markerId: MarkerId('현재 위치'),
              position: _center,
              infoWindow: InfoWindow(title: '현재 위치'),
            ),
          },
        ),
      ),
    );
  }
}
