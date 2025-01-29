import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComoFuncionaAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cómo Funciona la App',
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
              'Cómo Funciona la App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'La aplicación MyHelp se ejecuta en segundo plano para garantizar tu seguridad en todo momento. Una vez iniciada la sesión, puedes agitar tu teléfono para enviar un mensaje de alerta automáticamente sin necesidad de abrir la app. Además, cuenta con un botón de pánico grande, fácil de acceder en situaciones de emergencia.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Comandos de Voz',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'La app también puede ser activada por comandos de voz para enviar una señal de auxilio, permitiéndote pedir ayuda sin necesidad de interactuar físicamente con tu dispositivo.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Otras Funciones',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'MyHelp ofrece múltiples funcionalidades diseñadas para tu seguridad y tranquilidad. Entre ellas se encuentran la posibilidad de notificar a la policía, solicitar ayuda cercana, pedir presencia policial y avisar a tu familia en situaciones de emergencia.',
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
    home: ComoFuncionaAppScreen(),
  ));
}
