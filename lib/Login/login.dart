import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _idType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.jpg',
                height: 80,
                width: 80,
              ),
              const SizedBox(height: 24),
              const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 32),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Tipo de identificación',
                  border: OutlineInputBorder(),
                ),
                value: _idType,
                items: const [
                  DropdownMenuItem(
                      value: 'cc', child: Text('Cédula de Ciudadanía')),
                  DropdownMenuItem(
                      value: 'ce', child: Text('Cédula de Extranjería')),
                  DropdownMenuItem(
                      value: 'pasaporte', child: Text('Pasaporte')),
                  DropdownMenuItem(
                      value: 'ti', child: Text('Tarjeta de Identidad')),
                ],
                onChanged: (value) {
                  setState(() {
                    _idType = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Número de identificación',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    context.go('/forgotpasswordscreen');
                  },
                  child: const Text('¿Olvidó su contraseña?',
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Redirige a la ruta principal (/) después de iniciar sesión
                  context.go('/casascreen');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Aún no tienes una cuenta?',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  TextButton(
                    onPressed: () {
                      context.go('/registerscreen');
                    },
                    child: const Text(
                      'Crear Cuenta',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
