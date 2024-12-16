import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text(
              'Menú',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              context.go('/perfil');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Desaparecidos'),
            onTap: () {
              context.go('/desaparecidosscreen');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Solicitados'),
            onTap: () {
              context.go('/personassolicitadas');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              context.go('/configuracion');
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}
