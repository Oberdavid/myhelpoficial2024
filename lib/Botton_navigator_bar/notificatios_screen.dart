import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: ClipPath(
          clipper: _AppBarClipper(),
          child: AppBar(
            title: const Text(
              'Notificaciones',
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
                context.go('/casascreen');
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildNotificationTile(
              'Notificación 1', 'Descripción de la notificación 1'),
          _buildNotificationTile(
              'Notificación 2', 'Descripción de la notificación 2'),
          _buildNotificationTile(
              'Notificación 3', 'Descripción de la notificación 3'),
          // Más notificaciones aquí
        ],
      ),
    );
  }

  Widget _buildNotificationTile(String title, String description) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Lógica cuando se toca la notificación
        },
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
