import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oficial_app/Omboarding/omboarding1.dart';
import 'package:oficial_app/Omboarding/omboarding2.dart';
import 'package:oficial_app/Omboarding/omboarding3.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa SharedPreferences

// Asegúrate de importar tu pantalla de onboarding

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const OnboardingScreen1(
      imagePath: 'assets/family.jpg',
      title: 'Bienvenido a Myhelp',
      subtitle: 'Tu seguridad y tranquilidad son nuestra prioridad',
    ),
    const OnboardingScreen2(
      imagePath: 'assets/familia5.jpg',
      title: 'Funcionalidad',
      subtitle:
          'Siempre habrá alguien cerca para ayudarnos, ya nunca más te sentirás sol@',
    ),
    const OnboardingScreen3(
      imagePath: 'assets/familiaunida.jpg',
      title: 'Comienza Ahora',
      subtitle:
          'Desde ahora tendrás el control de tu seguridad y la de los tuyos en la palma de tu mano gracias a Myhelp.',
    ),
  ];

  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  // Método para guardar el estado del Onboarding
  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'showOnboarding', true); // Guarda que el Onboarding ya se mostró
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pages,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: TextButton(
              onPressed: () {
                context.go('/entrada'); // Redirige a la pantalla de entrada
              },
              child: const Text('Skip'),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () async {
                if (_currentPage == _pages.length - 1) {
                  // Si es la última página, guarda el estado y redirige
                  await _completeOnboarding();
                  if (context.mounted) {
                    context.go('/'); // Redirige a la pantalla principal
                  }
                } else {
                  // Si no es la última página, avanza a la siguiente
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Text(_currentPage == _pages.length - 1 ? 'Start' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
}
