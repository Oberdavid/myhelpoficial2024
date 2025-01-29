import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  _MapaScreenState createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  GoogleMapController? _mapController;
  LatLng? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar Ubicación')),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(4.6097, -74.0817),
          zoom: 12,
        ),
        onMapCreated: (controller) => _mapController = controller,
        onTap: (location) => setState(() => _selectedLocation = location),
        markers: _selectedLocation == null
            ? {}
            : {Marker(markerId: const MarkerId('selected'), position: _selectedLocation!)},
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () => Navigator.pop(context, _selectedLocation),
      ),
    );
  }
}