import 'package:flutter/material.dart';

class DesignTokens {
  // --- Colors: Precision Motion Palette ---
  
  // Primary (Court Green)
  static const primary = Color(0xFF006A3C);
  static const onPrimary = Color(0xFFCBFFD8);
  
  // Brand Accent (Lime Highlight)
  static const accentLime = Color(0xFFCCFF00); // The user's preferred highlight
  
  // Secondary (Muted Forest)
  static const secondary = Color(0xFF4E6300);
  static const onSecondary = Color(0xFFFFFFFF);
  
  // Neutral Surfaces - Light Mode
  static const surface = Color(0xFFF5F6F7);
  static const surfaceContainer = Color(0xFFEFF1F2);
  static const onSurface = Color(0xFF1A1C1D);
  static const onSurfaceVariant = Color(0xFF595C5D); // Secondary Text Light
  
  // Neutral Surfaces - Dark Mode
  static const darkBackground = Color(0xFF0C0C0E);
  static const darkSurface = Color(0xFF131315);
  static const darkSurfaceVariant = Color(0xFF1D1D20);
  static const onSurfaceDark = Color(0xFFFFFFFF);
  static const onSurfaceVariantDark = Color(0xFFA2ABAE); // Secondary Text Dark
  
  static const outline = Color(0xFF2C2C2F); // Border

  // --- Typography: The Editorial Edge ---
  
  static const double displayLargeSize = 56.0; // 3.5rem equivalent
  static const double displayMediumSize = 45.0;
  static const double headlineLargeSize = 32.0;
  
  // --- Shapes: Precision Edge ---
  
  static const double borderRadiusMd = 12.0;    // 0.75rem
  static const double borderRadiusXl = 24.0;    // 1.5rem (Cards)
  static const double borderRadiusFull = 9999.0; // Pills
  
  // --- Elevations: Mimicking natural light ---
  
  static const List<BoxShadow> softLift = [
    BoxShadow(
      color: Color(0x0F2C2F30), // rgba(44, 47, 48, 0.06)
      offset: Offset(0, 20),
      blurRadius: 40,
    ),
  ];
  
  // --- Gradients: Lit-from-within energy ---
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF005C34)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
