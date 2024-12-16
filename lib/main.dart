import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oficial_app/Agentes_screen/ConsultarPlacaScreen.dart';
import 'package:oficial_app/Agentes_screen/authority_home.dart';
import 'package:oficial_app/Agentes_screen/consultar_imei.dart';
import 'package:oficial_app/Agentes_screen/consultarcedulascreen.dart';
import 'package:oficial_app/Agentes_screen/detalles_solicitados.dart';
import 'package:oficial_app/Agentes_screen/detallesnovedadesscreen.dart';
import 'package:oficial_app/Agentes_screen/novedadesrecibidas.dart';
import 'package:oficial_app/Agentes_screen/personas_solicitadas.dart';
import 'package:oficial_app/Agentes_screen/verificacion_comunitaria.dart';
import 'package:oficial_app/servicios_rapidos_screen/desaparecidosscreen.dart';
import 'package:oficial_app/Servicios_rapidos_screen/detallesdesaparecidos.dart';
import 'package:oficial_app/Servicios_rapidos_screen/novedadesscreen.dart';
import 'package:oficial_app/Servicios_rapidos_screen/reportar_desaparecidos_screen.dart';
import 'package:oficial_app/drawer_user_screen/change_password_screen.dart';
import 'package:oficial_app/drawer_user_screen/change_plan_screen.dart';
import 'package:oficial_app/drawer_user_screen/como_funciona_laapp_screen.dart';
import 'package:oficial_app/drawer_user_screen/contactanos_screen.dart';
import 'package:oficial_app/drawer_user_screen/editar_peril_screen.dart';
import 'package:oficial_app/drawer_user_screen/politicas_privacidad.dart';
import 'package:oficial_app/drawer_user_screen/quienes_somos_screen.dart';
import 'package:oficial_app/ingreso_screen/forgot_password_screen.dart';
import 'package:oficial_app/ingreso_screen/login_screen.dart';
import 'package:oficial_app/botton_navigator_bar/feedback_screen.dart';
import 'package:oficial_app/botton_navigator_bar/location_screen.dart';
import 'package:oficial_app/botton_navigator_bar/notificatios_screen.dart';
import 'package:oficial_app/ingreso_screen/register_screen.dart';
import 'package:oficial_app/ingreso_screen/entrada_screen.dart';
import 'package:oficial_app/omboarding_screen/onboarding_flow.dart';
import 'package:oficial_app/home_screen/casa_screen.dart';
import 'package:oficial_app/drawer_user_screen/add_contact_screen.dart';
import 'package:oficial_app/drawer_user_screen/safety_tips_screen.dart';
import 'package:oficial_app/drawer_user_screen/my_team_screen.dart';
import 'package:oficial_app/mensajes_screen/mensajes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
}

final GoRouter _router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MyHomePage(child: child);
      },
      routes: [
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
          path: '/casascreen',
          builder: (context, state) => const CasaScreen(),
        ),
        GoRoute(
          path: '/changepasswordscreen',
          builder: (context, state) => const ChangePasswordScreen(),
        ),
        GoRoute(
          path: '/editarperfilscreen',
          builder: (context, state) => const EditarPerfilScreen(),
        ),
        GoRoute(
          path: '/changeplanscreen',
          builder: (context, state) => const ChangePlanScreen(),
        ),
        GoRoute(
          path: '/addContactscreen',
          builder: (context, state) => const AddContactScreen(),
        ),
        GoRoute(
          path: '/myteamscreen',
          builder: (context, state) => const MyTeamScreen(),
        ),
        GoRoute(
          path: '/notificatiosscreen',
          builder: (context, state) => const NotificationsScreen(),
        ),
        GoRoute(
          path: '/locationscreen',
          builder: (context, state) => LocationScreen(),
        ),
        GoRoute(
          path: '/feedbackscreen',
          builder: (context, state) => const FeedbackScreen(),
        ),
        GoRoute(
          path: '/novedadesscreen',
          builder: (context, state) => NovedadesScreen(),
        ),
        GoRoute(
          path: '/desaparecidosscreen',
          builder: (context, state) => DesaparecidosScreen(),
        ),
        GoRoute(
          path: '/reportardesaparecidoscreen',
          builder: (context, state) => ReportarDesaparecidoScreen(),
        ),
        GoRoute(
          path: '/quienessomosscreen',
          builder: (context, state) => QuienesSomosScreen(),
        ),
        GoRoute(
          path: '/comofuncionalaappscreen',
          builder: (context, state) => ComoFuncionaAppScreen(),
        ),
        GoRoute(
          path: '/contactanosscreen',
          builder: (context, state) => ContactanosScreen(),
        ),
        GoRoute(
          path: '/privacypolicyscreen',
          builder: (context, state) => const PrivacyPolicyScreen(),
        ),
        GoRoute(
          path: '/safetytipsscreen',
          builder: (context, state) => SafetyTipsScreen(),
        ),
        GoRoute(
          path: '/consultarplacascreen',
          builder: (context, state) => ConsultarPlacaScreen(),
        ),
        GoRoute(
          path: '/personassolicitadas',
          builder: (context, state) => WantedListScreen(),
        ),
        GoRoute(
          path: '/VerificacionComunitariaScreen',
          builder: (context, state) => const VerificacionComunitariaScreen(),
        ),
        GoRoute(
          path: '/consultarcedulascreen',
          builder: (context, state) => ConsultarCedulaScreen(),
        ),
        GoRoute(
          path: '/consultarimei',
          builder: (context, state) => ConsultarImeiScreen(),
        ),
        GoRoute(
          path: '/detallessolicitados/:id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return WantedDetailsScreen(id: id);
          },
        ),
        GoRoute(
          path: '/novedadesrecibidasscreen',
          builder: (context, state) => NovedadesRecibidasScreen(),
        ),
        GoRoute(
          path: '/detallesnovedadesscreen/:id/:latitude/:longitude',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            final latitude = double.parse(state.pathParameters['latitude']!);
            final longitude = double.parse(state.pathParameters['longitude']!);

            return DetallesNovedadesScreen(
              id: id,
              latitude: latitude,
              longitude: longitude,
            );
          },
        ),
        GoRoute(
          path: '/authorityHome',
          builder: (context, state) => AuthorityHomeScreen(),
        ),
        GoRoute(
          path: '/details/:type/:index',
          builder: (context, state) {
            final type = state.pathParameters['type']!;
            final index = int.parse(state.pathParameters['index']!);
            return DetallesDesaparecidoScreen(type: type, index: index);
          },
        ),
        // Agrega más rutas según sea necesario
      ],
    ),
  ],
);

class MyHomePage extends StatefulWidget {
  final Widget child;
  const MyHomePage({required this.child});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
    );
  }
}
