import 'package:flutter/material.dart';
import 'package:oficial_app/Screen/casa_screen.dart';
import 'package:oficial_app/Screen/notificaciones.dart';
import 'package:oficial_app/Screen/ubicacion.dart';
import 'package:oficial_app/Screen/zonapeligrosamaps.dart';

class IndexedStackNavigation extends StatefulWidget {
  const IndexedStackNavigation({super.key, required Widget child});

  @override
  State<IndexedStackNavigation> createState() => _IndexedStackNavigationState();
}

class _IndexedStackNavigationState extends State<IndexedStackNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CasaScreen(),
    const Ubicacion(),
    const Notificaciones(),
    DangerZonesMap(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        indicatorColor: Colors.blue,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_max_outlined),
            label: 'Inicio',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.location_on),
            icon: Icon(Icons.location_on_outlined),
            label: 'Ubicación',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.notification_add),
            icon: Icon(Icons.notification_important_outlined),
            label: 'Notificaciones',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.dangerous),
            icon: Icon(Icons.dangerous_outlined),
            label: 'Zona peligrosa',
          ),
        ],
      ),
    );
  }
}
