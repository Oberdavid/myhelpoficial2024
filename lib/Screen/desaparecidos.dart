import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class DesaparecidosScreen extends StatefulWidget {
  const DesaparecidosScreen({super.key});

  @override
  State<DesaparecidosScreen> createState() => _DesaparecidosScreenState();
}

class _DesaparecidosScreenState extends State<DesaparecidosScreen> {
  String _selectedCategory = 'Todos';
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    final location = Location();
    final currentLocation = await location.getLocation();
    setState(() {
      _currentLocation = LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Extraviados',
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
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/reportar'),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => _buildReporteCard(index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    final categorias = [
      'Todos',
      'Personas',
      'Vehículos',
      'Mascotas',
      'Documentos'
    ];
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ChoiceChip(
            label: Text(categorias[index]),
            selected: _selectedCategory == categorias[index],
            onSelected: (selected) => setState(() {
              _selectedCategory = selected ? categorias[index] : 'Todos';
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildReporteCard(int index) {
    return GestureDetector(
      onTap: () => context.go('/desaparecidos/details/$index'),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // LA IMAGEN NO EXISTE
            // SizedBox(
            //   height: 150,
            //   child: Image.asset(
            //     'assets/placeholder.jpg',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Título del reporte',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Categoría'),
                  Text('Ubicación: 4.6097, -74.0817'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
