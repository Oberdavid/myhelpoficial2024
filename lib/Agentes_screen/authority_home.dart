import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:oficial_app/drawe_agente_screen/custon_drawer.dart';
// Importa el nuevo Drawer

class AuthorityHomeScreen extends StatelessWidget {
  final List<String> imageList = [
    'assets/wanted1.PNG',
    'assets/wanted2.PNG',
    'assets/wanted3.PNG',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      appBar: AppBar(
        title: const Text(
          'Personas Solicitadas',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Cambia el color del icono del Drawer aquí
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Acción para el icono de notificaciones
              context.go('/notificaciones');
            },
            color: Colors.white,
          ),
        ],
      ),
      drawer: CustomDrawer(), // Usa el nuevo Drawer
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => context.go('/personassolicitadas'),
              child: CarouselSlider(
                options: CarouselOptions(height: 200.0, autoPlay: true),
                items: imageList.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.9),
                              blurRadius: 10,
                              spreadRadius: 5,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(imagePath, fit: BoxFit.fitWidth),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildOptionCard(context, 'Consultar Placa',
                      'assets/cars.png', '/consultarPlacaScreen'),
                  _buildOptionCard(context, 'Consultar Cédula',
                      'assets/docs.png', '/consultarCedulaScreen'),
                  _buildOptionCard(context, 'Consultar Imei', 'assets/imei.png',
                      '/consultarImei'),
                  _buildOptionCard(context, 'Alertas Recibidas',
                      'assets/notificacion.png', '/NovedadesRecibidasScreen'),
                  _buildOptionCard(context, 'Novedades', 'assets/pendiente.png',
                      '/novedadesrecibidas'),
                  _buildOptionCard(context, 'Verificación Comunitaria',
                      'assets/realizar.png', '/VerificacionComunitariaScreen'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
      BuildContext context, String title, String imagePath, String route) {
    return GestureDetector(
      onTap: () => context.go(route),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.9),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imagePath, height: 50),
              ),
            ),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AuthorityHomeScreen(),
  ));
}
