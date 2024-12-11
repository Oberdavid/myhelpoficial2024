import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class NavDrawer extends StatefulWidget {
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
                buildDrawerItem(Icons.home, 'Home', () {
                  context.go('/casa');
                }),
                buildDrawerItem(Icons.edit, 'Editar Perfil', () {
                  context.go('/EditarPerfilScreen');
                }),
                buildDrawerItem(Icons.lock, 'Cambiar Contraseña', () {
                  context.go('/ChangePasswordScreen');
                }),
                buildDrawerItem(Icons.swap_horizontal_circle, 'Cambiar Plan',
                    () {
                  context.go('/ChangePlanScreen');
                }),
                buildDrawerItem(Icons.security, 'Consejos de Seguridad', () {
                  context.go('/SafetyTipsScreen');
                }),
                buildDrawerItem(Icons.person, 'Agregar Contactos', () {
                  context.go('/AddContactScreen');
                }),
                buildDrawerItem(Icons.phone, 'Mi Dispositivo', () {
                  context.go('/MyTeamScreen');
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
                      context.go('/quienessomosscreen');
                    }),
                    buildDrawerSubItem('Cómo Funciona la App', () {
                      context.go('/comofuncionalaappscreen');
                    }),
                    buildDrawerSubItem('Contáctanos', () {
                      context.go('/contactanosscreen');
                    }),
                    buildDrawerSubItem('Políticas de Privacidad', () {
                      context.go('/PrivacyPolicyScreen');
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

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Drawer Example')),
      drawer: NavDrawer(),
      body: const Center(child: Text('Main Content')),
    ),
  ));
}
