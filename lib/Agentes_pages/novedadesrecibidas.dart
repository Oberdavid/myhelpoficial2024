import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NovedadesRecibidasScreen extends StatelessWidget {
  final List<Map<String, dynamic>> novedades = [
    {
      'id': '1',
      'titulo': 'Novedad 1',
      'fecha': '2024-10-01',
      'latitude': 40.748817,
      'longitude': -73.985428
    },
    {
      'id': '2',
      'titulo': 'Novedad 2',
      'fecha': '2024-10-02',
      'latitude': 34.052235,
      'longitude': -118.243683
    },
    // Agrega más novedades según sea necesario
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novedades',
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
            context.go('/authorityHome');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: novedades.length,
        itemBuilder: (context, index) {
          final novedad = novedades[index];
          return ListTile(
            title: Text(novedad['titulo']),
            subtitle: Text(novedad['fecha']),
            onTap: () {
              final latitude = novedad['latitude'] ?? 0.0;
              final longitude = novedad['longitude'] ?? 0.0;
              context.go(
                  '/detallesnovedadesscreen/${novedad['id']}/$latitude/$longitude');
            },
          );
        },
      ),
    );
  }
}
