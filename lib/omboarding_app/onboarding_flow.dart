import 'package:flutter/material.dart';
import 'onboarding_screen.dart';
import 'package:go_router/go_router.dart'; // Importa go_router

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    const OnboardingScreen(
      imagePath: 'assets/family.jpg',
      title: 'Bienvenido a Myhelp',
      subtitle: 'Tu seguridad y tranquilidad son nuestra prioridad',
    ),
    const OnboardingScreen(
      imagePath: 'assets/familia5.jpg',
      title: 'Funcionalidad',
      subtitle:
          'Siempre habrá alguien cerca para ayudarnos,  ya nunca mas te sentiras sol@',
    ),
    const OnboardingScreen(
      imagePath: 'assets/familiaunida.jpg',
      title: 'Comienza Ahora',
      subtitle:
          'Desde ahora tendras el control de tu seguridad y la de los tuyos en la palma de tu mano gracias a Myhelp.',
    ),
  ];

  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
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
                context.go('/entrada');
              },
              child: const Text('Skip'),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                if (_currentPage == _pages.length - 1) {
                  context.go('/entrada');
                } else {
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
