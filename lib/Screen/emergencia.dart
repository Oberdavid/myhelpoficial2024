import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../servicios/speech_service.dart';
import '../servicios/location_service.dart';
import '../servicios/alert_service.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final SpeechService _speechService = SpeechService();
  final LocationService _locationService = LocationService();
  final AlertService _alertService = AlertService();
  bool isListening = false;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  void _startListening() async {
    bool initialized = await _speechService.initialize();
    if (initialized) {
      setState(() => isListening = true);
      _speechService.listen(
        onResult: (text) {
          if (text.contains("auxilio") || text.contains("ayuda")) {
            _sendAlert();
          }
        },
      );
    }
  }

  void _sendAlert() async {
    Position position = await _locationService.getCurrentLocation();
    String message = "¡Necesito ayuda! Mi ubicación es: https://maps.google.com/?q=${position.latitude},${position.longitude}";
    String phoneNumber = "123456789"; // Número de emergencia
    await _alertService.sendAlert(phoneNumber, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo de Emergencia'),
      ),
      body: Center(
        child: Text(isListening ? "Escuchando..." : "Error: No se puede escuchar"),
      ),
    );
  }
}