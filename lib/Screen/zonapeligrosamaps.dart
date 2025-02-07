import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oficial_app/modelos/zonapeligrosa.dart';
import 'package:oficial_app/modelos/zonapeligrosa.dart';

class DangerZonesMap extends StatefulWidget {
  @override
  _DangerZonesMapState createState() => _DangerZonesMapState();
}

class _DangerZonesMapState extends State<DangerZonesMap> {
  GoogleMapController? mapController;
  LatLng? currentLocation;
  List<DangerZone> dangerZones = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _loadDangerZones();
  }

  // Obtener ubicación actual del usuario
  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });
  }

  // Cargar zonas peligrosas desde Firestore
  Future<void> _loadDangerZones() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('danger_zones')
        .get();

    List<DangerZone> zones = [];
    for (var doc in snapshot.docs) {
      zones.add(DangerZone.fromFirestore(doc.data() as Map<String, dynamic>));
    }

    setState(() {
      dangerZones = zones;
    });
  }

  // Dibujar polígonos en el mapa
  Set<Polygon> _buildPolygons() {
    return dangerZones.map((zone) {
      return Polygon(
        polygonId: PolygonId(zone.zoneId),
        points: zone.polygon,
        strokeWidth: 2,
        strokeColor: _getColor(zone.dangerLevel),
        fillColor: _getColor(zone.dangerLevel).withOpacity(0.3),
      );
    }).toSet();
  }

  // Color según nivel de peligro
  Color _getColor(int level) {
    switch (level) {
      case 1: return Colors.green;
      case 2: return Colors.yellow;
      case 3: return Colors.orange;
      case 4: return Colors.red;
      case 5: return Colors.purple;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Zonas Peligrosas')),
      body: currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation!,
                zoom: 14,
              ),
              polygons: _buildPolygons(),
              myLocationEnabled: true,
              onMapCreated: (controller) => mapController = controller,
            ),
    );
  }
}