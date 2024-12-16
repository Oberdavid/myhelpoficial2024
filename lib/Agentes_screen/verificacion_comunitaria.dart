// screens/verificacion_comunitaria_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';
import 'chat_comunitario.dart';

class VerificacionComunitariaScreen extends StatefulWidget {
  const VerificacionComunitariaScreen({Key? key}) : super(key: key);

  @override
  _VerificacionComunitariaScreenState createState() =>
      _VerificacionComunitariaScreenState();
}

class _VerificacionComunitariaScreenState
    extends State<VerificacionComunitariaScreen> {
  final Location _location = Location();
  LocationData? _currentLocation;
  double _radio = 1.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          throw Exception('Los servicios de ubicación están desactivados');
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw Exception('Permisos de ubicación denegados');
        }
      }

      final locationData = await _location.getLocation();
      setState(() => _currentLocation = locationData);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al obtener la ubicación: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _enviarMensaje() {
    if (_currentLocation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SalaChatComunitario(
            radio: _radio,
            ubicacionInicial: _currentLocation!,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: No se pudo obtener la ubicación actual'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación Comunitaria',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        backgroundColor: Colors.green,
        leading: IconButton(
          onPressed: () {
            context.go('/authorityHome');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ubicación actual:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  _currentLocation != null
                      ? Text(
                          'Lat: ${_currentLocation!.latitude?.toStringAsFixed(4)}\n'
                          'Lng: ${_currentLocation!.longitude?.toStringAsFixed(4)}',
                        )
                      : const Text('Ubicación no disponible'),
                  const SizedBox(height: 24),
                  Text(
                    'Radio de búsqueda (km):',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Slider(
                    value: _radio,
                    min: 0.1,
                    max: 5.0,
                    divisions: 49,
                    label: _radio.toString(),
                    onChanged: (value) {
                      setState(() => _radio = value);
                    },
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed:
                          _currentLocation != null ? _enviarMensaje : null,
                      icon: const Icon(Icons.send),
                      label: const Text('Iniciar Chat Comunitario'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
        backgroundColor: Colors.green,
      ),
    );
  }
}
