import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SafetyTipsScreen extends StatelessWidget {
  final List<String> safetyTips = [
    'Mantén tu teléfono cargado y lleva siempre un cargador portátil.',
    'Informa a un amigo o familiar sobre tu ubicación cuando salgas.',
    'Evita caminar solo en áreas desoladas o poco iluminadas.',
    'Confía en tu instinto, si algo te parece sospechoso, aléjate.',
    'Lleva contigo una identificación y un poco de efectivo de emergencia.',
    'Aprende técnicas básicas de autodefensa.',
    'Usa aplicaciones de seguridad para compartir tu ubicación en tiempo real.',
    'Establece contactos de emergencia en tu teléfono.',
    'Mantén tus pertenencias personales seguras y no exhibas objetos de valor.',
    'Conoce las salidas de emergencia de los lugares que frecuentas.',
  ];

  SafetyTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: ClipPath(
          clipper: _AppBarClipper(),
          child: AppBar(
            title: const Text('Consejos de Seguridad',
                style: TextStyle(color: Colors.white, fontSize: 28)),
            centerTitle: true,
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
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
        child: ListView.builder(
          itemCount: safetyTips.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  safetyTips[index],
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          },
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
