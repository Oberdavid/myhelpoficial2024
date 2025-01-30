import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart'; // Importa GoRouter
import 'package:oficial_app/Screen/navdrawer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:oficial_app/Device/shake.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class CasaScreen extends StatefulWidget {
  const CasaScreen({Key? key}) : super(key: key);

  @override
  _CasaScreenState createState() => _CasaScreenState();
}

class _CasaScreenState extends State<CasaScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late Shake _shake;
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isEmergencyModeActive = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _initializeShake();
  }

  void _initializeShake() {
    _shake = Shake();
    _shake.startListening(() async {
      _shake.pauseListening();
      await _showEmergencyDialog(context);
      _shake.resumeListening();
    });
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _showEmergencyDialog(BuildContext context) async {
    bool isDialogOpen = true;
    Timer? autoCloseTimer;

    autoCloseTimer = Timer(const Duration(seconds: 10), () {
      if (isDialogOpen && Navigator.of(context, rootNavigator: true).canPop()) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    });

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Presiona el botón de pánico',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/ayuda.png'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  isDialogOpen = false;
                  autoCloseTimer?.cancel();
                  setState(() {
                    _isEmergencyModeActive = !_isEmergencyModeActive;
                  });
                  if (_isEmergencyModeActive) {
                    _startListening();
                  } else {
                    _speech.stop();
                  }
                  Navigator.of(context, rootNavigator: true).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isEmergencyModeActive ? Colors.green : Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  _isEmergencyModeActive
                      ? 'Emergencia Activada'
                      : 'Activar Emergencia',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      isDialogOpen = false;
                      autoCloseTimer?.cancel();
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      isDialogOpen = false;
                      autoCloseTimer?.cancel();
                      Navigator.of(context, rootNavigator: true).pop();
                      _showMoreOptions(context);
                    },
                    child: const Text('Más opciones'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).then((_) {
      _shake.resumeListening();
      isDialogOpen = false;
      autoCloseTimer?.cancel();
    });
  }

  void _startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(
        onResult: (result) {
          if (result.recognizedWords.contains("auxilio") ||
              result.recognizedWords.contains("ayuda")) {
            _sendAlert();
          }
        },
      );
    }
  }

  Future<void> _sendAlert() async {
    Position position = await Geolocator.getCurrentPosition();
    String message =
        "¡Necesito ayuda! Mi ubicación es: https://maps.google.com/?q=${position.latitude},${position.longitude}";

    await _makePhoneCall('123');
    await _makePhoneCall('3017676159');
    await _makePhoneCall('456');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Alerta enviada a las autoridades y familiares')),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'No se pudo realizar la llamada a $phoneNumber';
    }
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.local_hospital),
              title: const Text('Llamar a una ambulancia'),
              onTap: () {
                Navigator.pop(context);
                _makePhoneCall('123');
              },
            ),
            ListTile(
              leading: const Icon(Icons.fire_truck),
              title: const Text('Llamar a los bomberos'),
              onTap: () {
                Navigator.pop(context);
                _makePhoneCall('456');
              },
            ),
            ListTile(
              leading: const Icon(Icons.security),
              title: const Text('Llamar a seguridad privada'),
              onTap: () {
                Navigator.pop(context);
                _makePhoneCall('3017676159');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _shake.pauseListening();
    _speech.stop();
    super.dispose();
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
      drawer: NavDrawer(
        onEmergencyPressed: () {
          Navigator.pop(context);
          _showEmergencyDialog(context);
        },
      ),
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
          color: Colors.blue,
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
                    'assets/notificacion.png', '/novedades'),
                _buildOptionCard(context, 'Extraviados',
                    'assets/desaparecido.png', '/desaparecidos'),
                _buildOptionCard(
                    context, 'Presencia Policial', 'assets/presencia.png', ''),
                _buildOptionCard(
                    context, 'Avisar a mi familia', 'assets/family.png', ''),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleOptionTap(BuildContext context, String title, String route) {
    if (route.isNotEmpty) {
      // Usa GoRouter para navegar
      context.push(route);
    } else {
      // Muestra un diálogo de confirmación antes de enviar la alerta
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Confirmar acción'),
          content: Text(
              '¿Estás seguro de que deseas enviar una alerta de "$title"?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cierra el diálogo
                _sendAlert(); // Envía la alerta
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Alerta de "$title" enviada exitosamente.'),
                  ),
                );
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      );
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
