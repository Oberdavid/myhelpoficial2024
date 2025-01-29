import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Asegúrate de agregar google_maps_flutter en pubspec.yaml
import 'package:location/location.dart'; // Para obtener la ubicación actual

class MyTeamScreen extends StatefulWidget {
  const MyTeamScreen({super.key});

  @override
  _MyTeamScreenState createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> {
  final Location _location = Location();
  late GoogleMapController _mapController;
  LatLng _currentPosition = const LatLng(0, 0);

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

  void _emitAlarm() {
    // Lógica para emitir una alarma
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alarma emitida!')),
    );
  }

  void _lockDevice() {
    // Lógica para bloquear el dispositivo
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Dispositivo bloqueado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: ClipPath(
          clipper: _AppBarClipper(),
          child: AppBar(
            title: const Text(
              'Encontrar Dispositivo',
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
              icon: const Icon(
                Icons.arrow_back,
              ),
              color: Colors.white,
              onPressed: () {
                context.go('/casascreen');
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _getCurrentLocation,
              child: const Text('Encontrar Mi Dispositivo'),
            ),
            const SizedBox(height: 20),
            Container(
              height: 300,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _currentPosition,
                  zoom: 15,
                ),
                myLocationEnabled: true,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _emitAlarm,
              child: const Text('Emitir Alarma'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _lockDevice,
              child: const Text('Bloquear Dispositivo'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 2, size.height + 20, size.width, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
