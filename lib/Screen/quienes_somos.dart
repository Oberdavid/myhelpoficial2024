import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuienesSomosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiénes Somos',
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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MyHelp',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'MyHelp es una aplicación imprescindible para quienes priorizan su seguridad y la de sus seres queridos. Aunque no somos parte de ningún organismo de seguridad, nuestra misión es modernizar y optimizar los servicios de respuesta que han quedado obsoletos. Con MyHelp, tienes una herramienta avanzada que facilita la comunicación y la acción rápida en situaciones de emergencia, brindando tranquilidad y protección en el día a día.',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: QuienesSomosScreen(),
  ));
}
