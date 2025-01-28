import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class NovedadesScreen extends StatefulWidget {
  const NovedadesScreen({super.key});

  @override
  State<NovedadesScreen> createState() => _NovedadesScreenState();
}

class _NovedadesScreenState extends State<NovedadesScreen> {
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _horaController = TextEditingController();
  LatLng? _selectedLocation;
  GoogleMapController? _mapController;
  String _selectedNovedad = ''; // Asigna un valor inicial

  void _selectLocation(LatLng? location) {
    if (location != null) {
      setState(() {
        _selectedLocation = location;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();
    final currentLocation = await location.getLocation();
    if (currentLocation.latitude != null && currentLocation.longitude != null) {
      _mapController?.animateCamera(CameraUpdate.newLatLng(
        LatLng(currentLocation.latitude!, currentLocation.longitude!),
      ));
    }
  }

  void _sendNovedad() {
    if (_selectedNovedad.isEmpty) {
      // Maneja el caso en que no se haya seleccionado ninguna novedad
      print('Por favor, selecciona una novedad');
      return;
    }
    print('Ubicación seleccionada: $_selectedLocation');
    print('Fecha: ${_fechaController.text}');
    print('Hora: ${_horaController.text}');
    print('Novedad: $_selectedNovedad');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Enviar Novedad',
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Mi ubicación'),
              readOnly: true,
              onTap: _getCurrentLocation,
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedNovedad.isEmpty ? null : _selectedNovedad,
              hint: const Text('Seleccione la novedad'),
              items: const [
                DropdownMenuItem(
                  child: Text('Me están siguiendo'),
                  value: 'Me están siguiendo',
                ),
                DropdownMenuItem(
                  child: Text('Están maltratando a alguien'),
                  value: 'Están maltratando a alguien',
                ),
                DropdownMenuItem(
                  value: 'Hay un vehículo sospechoso',
                  child: Text('Hay un vehículo sospechoso'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedNovedad = value ?? ''; // Actualiza el valor
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fechaController,
              decoration: const InputDecoration(labelText: 'Fecha'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _horaController,
              decoration: const InputDecoration(labelText: 'Hora'),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 2,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onTap: _selectLocation,
                markers: _selectedLocation == null
                    ? {}
                    : {
                        Marker(
                          markerId: const MarkerId('selectedLocation'),
                          position: _selectedLocation!,
                          draggable: true,
                          onDragEnd: _selectLocation,
                        ),
                      },
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendNovedad,
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
