import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_app/Screen/cambiar_plan.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences
import 'package:permission_handler/permission_handler.dart';

// Importa todas tus pantallas
import 'package:oficial_app/B_Navigator/IndexedStackNavigation.dart';
import 'package:oficial_app/Screen/casa_screen.dart';
import 'package:oficial_app/Screen/desaparecidos.dart';
import 'package:oficial_app/Screen/reportar_extravios.dart' as reportar;
import 'package:oficial_app/Screen/detalles.dart';
import 'package:oficial_app/Screen/novedades.dart';
import 'package:oficial_app/Screen/cambiar_contraseña.dart';
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
import 'package:oficial_app/Screen/emergencia.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Solicitar permisos
  await requestPermissions();

  // Obtener preferencias compartidas
  final prefs = await SharedPreferences.getInstance();
  final bool? showOnboarding = prefs.getBool('showOnboarding');

  runApp(MyApp(showOnboarding: showOnboarding));
}

Future<void> requestPermissions() async {
  await Permission.microphone.request();
  await Permission.location.request();
  await Permission.sms.request();

  if (await Permission.microphone.isDenied ||
      await Permission.location.isDenied ||
      await Permission.sms.isDenied) {
    print("Algunos permisos fueron denegados");
  }
}

class MyApp extends StatelessWidget {
  final bool? showOnboarding;

  MyApp({super.key, required this.showOnboarding});

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
      routerConfig: _router,
    );
  }

  String? _redirect(BuildContext context, GoRouterState state) {
    final isOnboardingDone = showOnboarding ?? false;
    if (!isOnboardingDone && state.uri.toString() != '/onboarding') {
      return '/onboarding';
    }
    return null;
  }

  late final GoRouter _router = GoRouter(
    initialLocation: '/entrada',
    redirect: _redirect,
    routes: [
      // Flujo de onboarding y autenticación
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingFlow(),
      ),
      GoRoute(
        path: '/entrada',
        builder: (context, state) => const EntradaScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
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
        path: '/novedades',
        builder: (context, state) => const NovedadesScreen(),
      ),
      // Módulo de desaparecidos
      GoRoute(
        path: '/desaparecidos',
        builder: (context, state) => DesaparecidosScreen(),
        routes: [
          GoRoute(
            path: '/reportar',
            builder: (context, state) => reportar.ReportarExtravioScreen(),
          ),
          GoRoute(
            path: 'details/:id',
            builder: (context, state) => DetallesScreen(
              reporteId: state.pathParameters['id']!,
              type: 'default', // Add appropriate type value
              index: 0, // Add appropriate index value
            ),
          ),
        ],
      ),

      // Ruta principal anidada
      ShellRoute(
        builder: (context, state, child) =>
            IndexedStackNavigation(child: child),
        routes: [
          // Pantalla principal
          GoRoute(
            path: '/casascreen',
            builder: (context, state) => const CasaScreen(),
          ),

          // Módulo de desaparecidos
          GoRoute(
            path: '/desaparecidos',
            builder: (context, state) => DesaparecidosScreen(),
            routes: [
              GoRoute(
                path: 'reportar',
                builder: (context, state) => reportar.ReportarExtravioScreen(),
              ),
              GoRoute(
                path: 'details/:id',
                builder: (context, state) => DetallesScreen(
                  reporteId: state.pathParameters['id']!,
                  type: 'default', // Add appropriate type value
                  index: 0, // Add appropriate index value
                ),
              ),
            ],
          ),
          // Configuraciones y otras pantallas
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
          GoRoute(
            path: '/emergencia',
            builder: (context, state) => EmergencyScreen(),
          ),
        ],
      ),
    ],
  );
}
