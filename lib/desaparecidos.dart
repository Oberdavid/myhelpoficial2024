import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:oficial_app/detalles_desaparecidos.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: _router,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// final GoRouter _router = GoRouter(
//   initialLocation: '/desaparecidosscreen',
//   routes: [
//     GoRoute(
//       path: '/desaparecidosscreen',
//       builder: (context, state) => DesaparecidosScreen(),
//     ),
//     GoRoute(
//       path: '/details/:type/:index',
//       builder: (context, state) {
//         final type = state.pathParameters['type']!;
//         final index = int.parse(state.pathParameters['index']!);
//         return DetallesDesaparecidoScreen(type: type, index: index);
//       },
//     ),
//     // Agrega más rutas según sea necesario
//   ],
// );

class DesaparecidosScreen extends StatefulWidget {
  const DesaparecidosScreen({super.key});

  @override
  State<DesaparecidosScreen> createState() => _DesaparecidosScreenState();
}

class _DesaparecidosScreenState extends State<DesaparecidosScreen> {
  // LatLng? _selectedLocation;
  // GoogleMapController? _mapController;
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // final location = Location();
    // final currentLocation = await location.getLocation();
    // setState(() {
    //   _selectedLocation =
    //       LatLng(currentLocation.latitude!, currentLocation.longitude!);
    // });
  }

  void _goToReportar() {
    context.go('/reportardesaparecidoscreen');
  }

  void _selectCategory(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _goToDetails(String type, int index) {
    context.go('/details/$type/$index');
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryIcon(Icons.person, 'Personas'),
                _buildCategoryIcon(Icons.directions_car, 'Vehículos'),
                _buildCategoryIcon(Icons.pets, 'Mascotas'),
                _buildCategoryIcon(Icons.description, 'Documentos'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 2,
                ),
                itemCount: 10, // Número de elementos a mostrar
                itemBuilder: (context, index) {
                  return _buildDesaparecidoCard(index);
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _goToReportar,
              child: const Text('Reportar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _selectCategory(title),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50),
              const SizedBox(height: 10),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesaparecidoCard(int index) {
    String type = '';

    if (_selectedCategory == 'Personas') {
      type = 'personas';
      return GestureDetector(
        onTap: () => _goToDetails(type, index),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('assets/desaparecido_$index.png', height: 100),
              // const SizedBox(height: 10),
              // Text('Desaparecido $index'),
              Image.asset('assets/desaparecido.png', height: 50),
              const SizedBox(height: 10),
              Text('Desaparecido'),
            ],
          ),
        ),
      );
    } else if (_selectedCategory == 'Vehículos') {
      type = 'vehiculos';
      return GestureDetector(
        onTap: () => _goToDetails(type, index),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/vehiculo_$index.png', height: 100),
              const SizedBox(height: 10),
              Text('Vehículo $index'),
            ],
          ),
        ),
      );
    } else if (_selectedCategory == 'Mascotas') {
      type = 'mascotas';
      return GestureDetector(
        onTap: () => _goToDetails(type, index),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/mascota_$index.png', height: 100),
              const SizedBox(height: 10),
              Text('Mascota $index'),
            ],
          ),
        ),
      );
    } else if (_selectedCategory == 'Documentos') {
      type = 'documentos';
      return GestureDetector(
        onTap: () => _goToDetails(type, index),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/documento_$index.png', height: 100),
              const SizedBox(height: 10),
              Text('Documento $index'),
            ],
          ),
        ),
      );
    } else {
      return Container(); // Si no hay una categoría seleccionada, muestra un contenedor vacío
    }
  }
}
