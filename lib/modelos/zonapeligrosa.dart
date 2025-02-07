import 'package:google_maps_flutter/google_maps_flutter.dart';

class DangerZone {
  final String zoneId;
  final String name;
  final List<LatLng> polygon;
  final int dangerLevel;

  DangerZone({
    required this.zoneId,
    required this.name,
    required this.polygon,
    required this.dangerLevel,
  });

  // Convertir datos de Firestore a este modelo
  factory DangerZone.fromFirestore(Map<String, dynamic> data) {
    return DangerZone(
      zoneId: data['zoneId'],
      name: data['name'],
      polygon: (data['polygon']['coordinates'] as List)
          .map((point) => LatLng(point['latitude'], point['longitude']))
          .toList(),
      dangerLevel: data['dangerLevel'],
    );
  }
}