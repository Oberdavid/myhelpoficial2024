import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingScreen2 extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const OnboardingScreen2(
      {required this.imagePath, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, // Ajusta el ancho según sea necesario
              height: 100, // Ajusta la altura según sea necesario
              child: Image.asset(imagePath),
            ),
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
