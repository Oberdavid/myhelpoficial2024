import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// Para formatear fechas y horas
import 'package:intl/intl.dart';


class NovedadesScreen extends StatefulWidget {
  @override
  _NovedadesScreenState createState() => _NovedadesScreenState();
}

class _NovedadesScreenState extends State<NovedadesScreen> {
  TextEditingController _fechaController = TextEditingController();
  TextEditingController _horaController = TextEditingController();
  LatLng? _selectedLocation;
  GoogleMapController? _mapController;
  String _selectedNovedad = '';
  Location _location = Location();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final currentLocation = await _location.getLocation();
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _selectedLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!);
          _isLoading = false;
        });
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(_selectedLocation!, 15),
        );
      }
    } catch (e) {
      print("Error obteniendo la ubicación: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _selectLocation(LatLng location) {
    setState(() {
      _selectedLocation = location;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _fechaController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _horaController.text = picked.format(context);
      });
    }
  }

  void _sendNovedad() {
    if (_selectedNovedad.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona una novedad')),
      );
      return;
    }
    if (_selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona una ubicación')),
      );
      return;
    }
    if (_fechaController.text.isEmpty || _horaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, selecciona fecha y hora')),
      );
      return;
    }

    print('Ubicación seleccionada: $_selectedLocation');
    print('Fecha: ${_fechaController.text}');
    print('Hora: ${_horaController.text}');
    print('Novedad: $_selectedNovedad');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Novedad enviada exitosamente')),
    );
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
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
                        _selectedNovedad = value ?? '';
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _fechaController,
                          decoration: const InputDecoration(labelText: 'Fecha'),
                          readOnly: true,
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextField(
                          controller: _horaController,
                          decoration: const InputDecoration(labelText: 'Hora'),
                          readOnly: true,
                          onTap: () => _selectTime(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _selectedLocation ?? const LatLng(0, 0),
                        zoom: 15,
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
                                onDragEnd: (LatLng newPosition) {
                                  _selectLocation(newPosition);
                                },
                              ),
                            },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _sendNovedad,
                    child: const Text('Enviar Novedad'),
                  ),
                ],
              ),
            ),
    );
  }
}
