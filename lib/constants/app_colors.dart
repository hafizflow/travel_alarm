import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF0A0E27);
  static const Color secondaryBlue = Color(0xFF1A1F4D);
  static const Color accentPurple = Color(0xFF5200FF);
  static const Color lightPurple = Color(0xFF5200FF);

  // Background
  static const Color backgroundDark = Color(0xFF0A0E27);
  static const Color cardBackground = Color(0xFF1E2347);

  // Text Colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGray = Color(0xFFB8BED9);
  static const Color textDarkGray = Color(0xFF8A8FA6);

  // Button Colors
  static const Color buttonPurple = Color(0xFF6C3EFF);
  static const Color buttonDisabled = Color(0xFF4A4E6D);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFFFC107);

  // Gradients
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color.fromARGB(255, 4, 9, 37), Color.fromARGB(255, 33, 39, 99)],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF5200FF), Color(0xFF5200FF)],
  );
}
