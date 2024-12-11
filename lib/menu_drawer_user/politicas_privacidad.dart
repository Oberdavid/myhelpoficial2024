import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Políticas de Privacidad',
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
          onPressed: () {
            context.go('/casascreen');
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const _LastUpdatedText(),
          const SizedBox(height: 20),
          _buildSection(
            'Introducción',
            'Bienvenido a SafeGuard. Nos comprometemos a proteger tu privacidad y '
                'garantizar la seguridad de tus datos personales. Esta política explica '
                'cómo recopilamos, utilizamos y protegemos tu información.',
          ),
          _buildSection(
            'Información que Recopilamos',
            null,
            subsections: {
              'Información proporcionada por el usuario': [
                'Datos de registro (nombre, correo electrónico)',
                'Información de contactos de emergencia',
                'Ubicación (cuando la función está activada)',
                'Información médica relevante (opcional)',
                'Fotografía de perfil (opcional)',
              ],
              'Información recopilada automáticamente': [
                'Datos de uso de la aplicación',
                'Información del dispositivo',
                'Registros de actividad',
                'Datos de ubicación en segundo plano (con autorización)',
              ],
            },
          ),
          _buildSection(
            'Uso de la Información',
            'Utilizamos tu información para:',
            bulletPoints: [
              'Proporcionar servicios de seguridad personal',
              'Responder a situaciones de emergencia',
              'Mejorar nuestros servicios',
              'Enviar alertas y notificaciones importantes',
              'Mantener tu cuenta segura',
            ],
          ),
          _buildSecuritySection(),
          _buildSection(
            'Compartir Información',
            null,
            subsections: {
              'Compartimos tu información con:': [
                'Contactos de emergencia designados',
                'Servicios de emergencia cuando sea necesario',
                'Proveedores de servicios esenciales',
              ],
              'Nunca compartiremos:': [
                'Tus datos con terceros para fines comerciales',
                'Información sensible sin tu consentimiento',
              ],
            },
          ),
          _buildSection(
            'Tus Derechos',
            'Como usuario, tienes derecho a:',
            bulletPoints: [
              'Acceder a tus datos personales',
              'Corregir información inexacta',
              'Eliminar tu cuenta y datos asociados',
              'Exportar tus datos',
              'Revocar permisos de acceso',
              'Opt-out de ciertas funciones',
            ],
          ),
          _buildSection(
            'Retención de Datos',
            'Mantenemos tus datos personales solo mientras:',
            bulletPoints: [
              'Tu cuenta esté activa',
              'Sea necesario para nuestros servicios',
              'Lo requiera la ley',
            ],
          ),
          _buildSection(
            'Menores de Edad',
            'Nuestra aplicación no está diseñada para menores de 18 años. '
                'No recopilamos intencionalmente información de menores de edad.',
          ),
          _buildSection(
            'Cambios en la Política',
            'Podemos actualizar esta política. Te notificaremos sobre cambios importantes mediante:',
            bulletPoints: [
              'Notificaciones en la app',
              'Correo electrónico',
              'Aviso en nuestra web',
            ],
          ),
          _buildContactSection(),
          _buildConsentSection(),
          const SizedBox(height: 20),
          const _Footer(),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    String? description, {
    List<String>? bulletPoints,
    Map<String, List<String>>? subsections,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        if (description != null)
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        if (bulletPoints != null) ...[
          const SizedBox(height: 10),
          ...bulletPoints.map((point) => _buildBulletPoint(point)),
        ],
        if (subsections != null) ...[
          const SizedBox(height: 10),
          ...subsections.entries.map((entry) => _buildSubsection(
                entry.key,
                entry.value,
              )),
        ],
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubsection(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 5),
        ...points.map((point) => _buildBulletPoint(point)),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _buildSecuritySection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: _buildSection(
        'Protección de Datos',
        'Implementamos medidas de seguridad robustas:',
        bulletPoints: [
          'Encriptación de datos de extremo a extremo',
          'Autenticación de dos factores',
          'Monitoreo continuo de seguridad',
          'Almacenamiento seguro en servidores protegidos',
          'Acceso restringido a datos personales',
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contacto',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          _buildContactInfo(Icons.email, 'myhelpcolombia@gmail.com'),
          _buildContactInfo(Icons.phone, '+57 300 123 4567'),
          _buildContactInfo(
            Icons.location_on,
            '123 Security Street, Tech City, TC 12345',
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsentSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Consentimiento',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Al usar nuestra aplicación, aceptas esta política de privacidad y el '
            'procesamiento de tu información como se describe aquí.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _LastUpdatedText extends StatelessWidget {
  const _LastUpdatedText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Última actualización: 24 de octubre de 2024',
        style: TextStyle(
          fontSize: 14,
          fontStyle: FontStyle.italic,
          color: Colors.grey,
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      child: const Center(
        child: Text(
          '© 2024 SafeGuard. Todos los derechos reservados.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
