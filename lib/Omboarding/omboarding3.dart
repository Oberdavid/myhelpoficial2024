import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen3 extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingScreen3(
      {super.key,
      required this.imagePath,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath), // Asegúrate de tener tus imágenes en assets
            const SizedBox(height: 20),
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
