import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:share_plus/share_plus.dart';

class Ubicacion extends StatefulWidget {
  const Ubicacion({super.key});

  @override
  _ubicacionState createState() => _ubicacionState();
}

class _ubicacionState extends State<Ubicacion> {
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
            left: 10,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _getCurrentLocation,
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 56,
                  height: 56,
                  child: const Icon(Icons.my_location, color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 10,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: _shareLocation,
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  width: 56,
                  height: 56,
                  child: const Icon(Icons.share, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
