import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class NavDrawer extends StatefulWidget {
  final VoidCallback onEmergencyPressed; // Callback para el botón de emergencia

  const NavDrawer({super.key, required this.onEmergencyPressed});

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.cyan],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nombre de Usuario',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'email@ejemplo.com',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Botón de emergencia (nuevo)
                ListTile(
                  leading: const Icon(Icons.warning, color: Colors.red),
                  title: Text(
                    'Modo de Emergencia',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  onTap: () {
                    widget
                        .onEmergencyPressed(); // Llama al diálogo de emergencia
                  },
                ),
                buildDrawerItem(Icons.home, 'Home', () {
                  context.go('/casascreen');
                }),
                buildDrawerItem(Icons.edit, 'Editar Perfil', () {
                  context.go('/editarPerfil');
                }),
                buildDrawerItem(Icons.lock, 'Cambiar Contraseña', () {
                  context.go('/cambiarcontrasena');
                }),
                buildDrawerItem(Icons.swap_horizontal_circle, 'Cambiar Plan',
                    () {
                  context.go('/cambiarplan');
                }),
                buildDrawerItem(Icons.security, 'Consejos de Seguridad', () {
                  context.go('/consejosdeseguridad');
                }),
                buildDrawerItem(Icons.person, 'Agregar Contactos', () {
                  context.go('/agregarcontactos');
                }),
                buildDrawerItem(Icons.phone, 'Mi Dispositivo', () {
                  context.go('/midispositivo');
                }),
                ExpansionTile(
                  leading: const Icon(Icons.info, color: Colors.blue),
                  title: Text(
                    'Más Información',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  children: [
                    buildDrawerSubItem('Quiénes Somos', () {
                      context.go('/quienessomos');
                    }),
                    buildDrawerSubItem('Cómo Funciona la App', () {
                      context.go('/comofunciona');
                    }),
                    buildDrawerSubItem('Contáctanos', () {
                      context.go('/contactanos');
                    }),
                    buildDrawerSubItem('Políticas de Privacidad', () {
                      context.go('/PrivacyPolicy');
                    }),
                  ],
                ),
                buildDrawerItem(Icons.exit_to_app, 'Salir de la App', () {
                  context.go('/login');
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerSubItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
