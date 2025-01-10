import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_app/drawer_user_screen/navdrawer.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CasaScreen extends StatefulWidget {
  const CasaScreen({Key? key}) : super(key: key);

  @override
  _CasaScreenState createState() => _CasaScreenState();
}

class _CasaScreenState extends State<CasaScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedIndex = _calculateSelectedIndex(context);
    });
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_laucher");
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showNotification(String title) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Acción realizada',
      'Has seleccionado: $title',
      platformChannelSpecifics,
    );
  }

  void _handleOptionTap(BuildContext context, String title, String route) {
    if (route.isNotEmpty) {
      GoRouter.of(context).push(route);
    } else {
      _showConfirmationDialog(context, title);
    }
  }

  void _showConfirmationDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enviar notificación'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Usa este servicio solo en caso de emergencia'),
              SizedBox(height: 10),
              Text(
                  'Se enviará una notificación para que vengan en tu ayuda. ¿Estás seguro/a?'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showNotification(title);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Notificación enviada.'),
                  ),
                );
              },
              child: const Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> securityTips = [
      'Mantén tu teléfono cargado y lleva siempre un cargador portátil.',
      'Informa a un amigo o familiar sobre tu ubicación cuando salgas.',
      'Evita caminar solo en áreas desoladas o poco iluminadas.',
      'Confía en tu instinto, si algo te parece sospechoso, aléjate.',
      'Lleva contigo una identificación y un poco de efectivo de emergencia.',
      'Aprende técnicas básicas de autodefensa.',
      'Usa aplicaciones de seguridad para compartir tu ubicación en tiempo real.',
      'Establece contactos de emergencia en tu teléfono.',
      'Mantén tus pertenencias personales seguras y no exhibas objetos de valor.',
      'Conoce las salidas de emergencia de los lugares que frecuentas.'
    ];

    return Scaffold(
      drawer: NavDrawer(),
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        title: Text(
          'Bienvenido, a Myhelp',
          style: GoogleFonts.poppins(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.blue, // Cambia el color del icono del Drawer aquí
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.blue),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 238.0,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage('assets/family.jpg'),
                  fit: BoxFit.fill,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 2,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                      child: Text(
                        "Tu tranquilidad es nuestra prioridad",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: const Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Consejos de Seguridad',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
            ),
            const SizedBox(height: 8),
            CarouselSlider(
              options: CarouselOptions(
                height: 120.0,
                viewportFraction: 0.8,
                autoPlay: true,
                autoPlayCurve: Curves.easeInOut,
                autoPlayInterval: const Duration(seconds: 5),
                enlargeCenterPage: true,
              ),
              items: securityTips.map((tip) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            tip,
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.9,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: <Widget>[
                _buildOptionCard(
                    context, 'Ayuda Cercana', 'assets/ayuda.png', ''),
                _buildOptionCard(
                    context, 'Avisar a la policía', 'assets/policia.png', ''),
                _buildOptionCard(context, 'Enviar Novedad',
                    'assets/notificacion.png', '/novedadesscreen'),
                _buildOptionCard(context, 'Extraviados',
                    'assets/desaparecido.png', '/desaparecidosscreen'),
                _buildOptionCard(
                    context, 'Presencia Policial', 'assets/presencia.png', ''),
                _buildOptionCard(
                    context, 'Avisar a mi familia', 'assets/family.png', ''),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 30),
                label: 'Casa',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications, size: 30),
                label: 'Notificaciones',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_on, size: 30),
                label: 'Ubicación',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.feedback, size: 30),
                label: 'Comentarios',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
          ),
        ),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/notificatios')) {
      return 1;
    }
    if (location.startsWith('/location')) {
      return 2;
    }
    if (location.startsWith('/Feedback')) {
      return 3;
    }
    return 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        GoRouter.of(context).go('/casascreen');
        break;
      case 1:
        GoRouter.of(context).go('/notificatiosscreen');
        break;
      case 2:
        GoRouter.of(context).go('/locationscreen');
        break;
      case 3:
        GoRouter.of(context).go('/Feedbackscreen');
        break;
    }
  }

  Widget _buildOptionCard(
      BuildContext context, String title, String imagePath, String route) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        onTap: () => _handleOptionTap(context, title, route),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
