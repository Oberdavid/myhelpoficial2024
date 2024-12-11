import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Location _location = Location();
  late GoogleMapController _mapController;
  LatLng _initialPosition = const LatLng(4.2977429, -74.8075868);
  LatLng _currentPosition = const LatLng(4.2977429, -74.8075868);

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final locationData = await _location.getLocation();
    setState(() {
      _currentPosition =
          LatLng(locationData.latitude!, locationData.longitude!);
    });
    _mapController.animateCamera(
      CameraUpdate.newLatLng(_currentPosition),
    );
  }

  void _shareLocation() {
    final String locationMessage =
        'Estoy aquí: https://maps.google.com/?q=${_currentPosition.latitude},${_currentPosition.longitude}';
    Share.share(locationMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubicación',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            context.go('/casascreen');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 15,
            ),
            myLocationEnabled: true,
          ),
          Positioned(
            bottom: 50,
            right: 10,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              tooltip: 'Obtener Ubicación Actual',
              child: const Icon(Icons.my_location),
            ),
          ),
          Positioned(
            bottom: 120,
            right: 10,
            child: FloatingActionButton(
              onPressed: _shareLocation,
              tooltip: 'Compartir Ubicación',
              child: const Icon(Icons.share),
            ),
          ),
        ],
      ),
    );
  }
}
