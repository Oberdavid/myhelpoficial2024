import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences
import 'package:oficial_app/B_Navigator/IndexedStackNavigation.dart';
import 'package:oficial_app/Screen/desaparecidos.dart';
import 'package:oficial_app/Screen/detalles_desaparecidos.dart';
import 'package:oficial_app/Screen/novedades.dart';
import 'package:oficial_app/Screen/reportar_desaparecidos.dart';
import 'package:oficial_app/Screen/cambiar_contraseña.dart';
import 'package:oficial_app/Screen/cambiar_plan.dart';
import 'package:oficial_app/Screen/como_funciona.dart';
import 'package:oficial_app/Screen/contactanos.dart';
import 'package:oficial_app/Screen/editar_peril.dart';
import 'package:oficial_app/Screen/politicas_privacidad.dart';
import 'package:oficial_app/Screen/quienes_somos.dart';
import 'package:oficial_app/Login/olvidar_contraseña.dart';
import 'package:oficial_app/Login/login.dart';
import 'package:oficial_app/Login/register_screen.dart';
import 'package:oficial_app/Screen/entrada_screen.dart';
import 'package:oficial_app/Omboarding/onboarding_flow.dart';
import 'package:oficial_app/Screen/agregar_contactos.dart';
import 'package:oficial_app/Screen/consejos_seguridad.dart';
import 'package:oficial_app/Screen/mi_dispositivo.dart';
import 'package:oficial_app/Device/shake.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Necesario para usar SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  final bool? showOnboarding = prefs.getBool('showOnboarding') ?? true;

  runApp(MyApp(showOnboarding: showOnboarding));
}

class MyApp extends StatelessWidget {
  final bool? showOnboarding;

  const MyApp({super.key, required this.showOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge:
              GoogleFonts.poppins(fontSize: 32.0, fontWeight: FontWeight.bold),
          bodyLarge: GoogleFonts.poppins(fontSize: 16.0),
        ),
      ),
      routerConfig: _router(showOnboarding),
    );
  }

  GoRouter _router(bool? showOnboarding) {
    return GoRouter(
      initialLocation: showOnboarding == null
          ? '/onboarding'
          : '/login', // Ruta inicial dinámica
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) =>
              const IndexedStackNavigation(), // Pantalla principa
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingFlow(), // Onboarding
        ),
        GoRoute(
          path: '/entrada',
          builder: (context, state) => const EntradaScreen(),
        ),
        GoRoute(
          path: '/registerscreen',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/forgotpasswordscreen',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: '/cambiarcontrasena',
          builder: (context, state) => const ChangePasswordScreen(),
        ),
        GoRoute(
          path: '/editarperfil',
          builder: (context, state) => const EditarPerfilScreen(),
        ),
        GoRoute(
          path: '/cambiarplan',
          builder: (context, state) => const ChangePlanScreen(),
        ),
        GoRoute(
          path: '/agregarcontactos',
          builder: (context, state) => const AddContactScreen(),
        ),
        GoRoute(
          path: '/midispositivo',
          builder: (context, state) => const MyTeamScreen(),
        ),
        GoRoute(
          path: '/novedades',
          builder: (context, state) => NovedadesScreen(),
        ),
        GoRoute(
          path: '/desaparecidos',
          builder: (context, state) => DesaparecidosScreen(),
        ),
        GoRoute(
          path: '/reportardesaparecidos',
          builder: (context, state) => ReportarDesaparecidoScreen(),
        ),
        GoRoute(
          path: '/quienessomos',
          builder: (context, state) => QuienesSomosScreen(),
        ),
        GoRoute(
          path: '/comofunciona',
          builder: (context, state) => ComoFuncionaAppScreen(),
        ),
        GoRoute(
          path: '/contactanos',
          builder: (context, state) => ContactanosScreen(),
        ),
        GoRoute(
          path: '/politicasprivacidad',
          builder: (context, state) => const PrivacyPolicyScreen(),
        ),
        GoRoute(
          path: '/consejosseguridad',
          builder: (context, state) => SafetyTipsScreen(),
        ),
        // Agrega más rutas según sea necesario
      ],
    );
  }
}
