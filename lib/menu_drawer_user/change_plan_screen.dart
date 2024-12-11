import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChangePlanScreen extends StatelessWidget {
  const ChangePlanScreen({super.key});

  void _redirectToPaymentPlatform(BuildContext context) {
    // Aquí va la lógica para redirigir a la plataforma de pago
    // Por ejemplo, podrías usar un paquete como url_launcher para abrir el navegador
    // Ejemplo: launchUrl('https://www.tu-plataforma-de-pago.com');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: ClipPath(
          clipper: _AppBarClipper(),
          child: AppBar(
            title: const Text(
              'Cambiar Plan',
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
              icon: const Icon(
                Icons.arrow_back,
              ),
              color: Colors.white,
              onPressed: () {
                context.go('/casascreen');
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Logo de la app
            Center(
              child: Image.asset('assets/logo.jpg',
                  height: 100), // Asegúrate de tener el logotipo en assets
            ),
            const SizedBox(height: 20),
            // Plan gratuito
            const PlanCategory(
              planTitle: 'Plan Gratuito',
              features: [
                '• Ayuda Cercana: 5 veces al mes.',
                '• Avisar a la Policía: 2 veces al mes.',
                '• Enviar Novedad: 10 veces al mes.',
                '• Desaparecidos: 1 caso activo a la vez.',
                '• Presencia Policial: 2 veces al mes.',
                '• Avisar a la Familia: Hasta 3 contactos.',
              ],
              onButtonPressed: null, // No hay acción para el plan gratuito
              isFreePlan: true, // Indica que es el plan gratuito
            ),
            const SizedBox(height: 20),
            // Plan de 20,000 pesos mensuales
            PlanCategory(
              planTitle: 'Plan Básico - 20,000 pesos/mes',
              features: const [
                '• Ayuda Cercana: 10 veces al mes.',
                '• Avisar a la Policía: 12 veces al mes.',
                '• Enviar Novedad: 15 veces al mes.',
                '• Desaparecidos: Múltiples casos activos.',
                '• Presencia Policial: 4 veces al mes.',
                '• Avisar a la Familia: Hasta 4 contactos.',
                '• Bloquear Dispositivos: 1 vez al mes.',
                '• Encontrar mi Dispositivo: 1 vez al mes.',
              ],
              onButtonPressed: () => _redirectToPaymentPlatform(context),
            ),
            const SizedBox(height: 20),
            // Plan de 35,000 pesos mensuales
            PlanCategory(
              planTitle: 'Plan Avanzado - 35,000 pesos/mes',
              features: const [
                '• Todo del Plan Básico.',
                '• Atención Prioritaria.',
                '• Grupo familiar:  Ideal para familias que desean monitorear la seguridad de cada miembro 2 personas.',
                '• Encuéntrame: Perfecto para que los usuarios envíen su ubicación en tiempo real a amigos o familiares durante emergencias..',
                '• Activación por Voz: Con solo decir las palabras asignadas podras enviar la solicitud sin abrir la app .',
              ],
              onButtonPressed: () => _redirectToPaymentPlatform(context),
            ),
            const SizedBox(height: 20),
            // Plan de 50,000 pesos mensuales
            PlanCategory(
              planTitle: 'Plan Premium - 50,000 pesos/mes',
              features: const [
                '• Todo del Plan Avanzado.',
                '• Soporte 24/7.',
                '• Servicios Exclusivos.',
                '• Presencia Policial: Ilimitados.',
                '• Grupo familiar:  Ideal para familias que desean monitorear la seguridad de cada miembro 4 personas.',
                '• Activación por Voz: Con solo decir las palabras asignadas podras enviar la solicitud sin abrir la app.',
                '• Descuentos en Asociados.',
              ],
              onButtonPressed: () => _redirectToPaymentPlatform(context),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCategory extends StatelessWidget {
  final String planTitle;
  final List<String> features;
  final VoidCallback? onButtonPressed;
  final bool isFreePlan;

  const PlanCategory({
    required this.planTitle,
    required this.features,
    this.onButtonPressed,
    this.isFreePlan = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              planTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...features.map((feature) => Text(feature)).toList(),
            const SizedBox(height: 10),
            if (!isFreePlan)
              ElevatedButton(
                onPressed: onButtonPressed,
                child: const Text('Actualizar'),
              ),
          ],
        ),
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
