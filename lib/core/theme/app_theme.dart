import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: DesignTokens.primary,
      primary: DesignTokens.primary,
      onPrimary: Colors.white,
      secondary: DesignTokens.secondary,
      secondaryContainer: DesignTokens.accentLime,
      onSecondaryContainer: Colors.black,
      surface: DesignTokens.surface,
      onSurface: DesignTokens.onSurface,
      onSurfaceVariant: DesignTokens.onSurfaceVariant,
      outline: DesignTokens.outline,
    ),

    // Typography: Standardizing on IBM Plex Sans Thai
    textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(ThemeData.light().textTheme)
        .copyWith(
          displayLarge: GoogleFonts.ibmPlexSansThai(
            fontSize: DesignTokens.displayLargeSize,
            fontWeight: FontWeight.bold,
            color: DesignTokens.onSurface,
          ),
          displayMedium: GoogleFonts.ibmPlexSansThai(
            fontSize: DesignTokens.displayMediumSize,
            fontWeight: FontWeight.bold,
            color: DesignTokens.onSurface,
          ),
          headlineLarge: GoogleFonts.ibmPlexSansThai(
            fontSize: DesignTokens.headlineLargeSize,
            fontWeight: FontWeight.w600,
            color: DesignTokens.onSurface,
          ),
          labelLarge: GoogleFonts.ibmPlexSansThai(fontWeight: FontWeight.w500),
        ),

    // Components Styling: The 'No-Line' Rule
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(DesignTokens.borderRadiusXl),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DesignTokens.surfaceContainer,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
        borderSide: BorderSide.none,
      ),
      enabledBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
        borderSide: BorderSide.none,
      ),
      focusedBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.borderRadiusMd),
        borderSide: const BorderSide(color: DesignTokens.primary, width: 2),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: DesignTokens.primary,
      brightness: Brightness.dark,
      primary: DesignTokens.primary,
      onPrimary: Colors.white,
      secondary: DesignTokens.secondary,
      secondaryContainer: DesignTokens.accentLime,
      onSecondaryContainer: Colors.black,
      surface: DesignTokens.darkSurface,
      onSurface: DesignTokens.onSurfaceDark,
      onSurfaceVariant: DesignTokens.onSurfaceVariantDark,
      outline: DesignTokens.outline,
    ),
    textTheme: GoogleFonts.ibmPlexSansThaiTextTheme(ThemeData.dark().textTheme)
        .copyWith(
          displayLarge: GoogleFonts.ibmPlexSansThai(
            fontSize: DesignTokens.displayLargeSize,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.ibmPlexSansThai(
            fontSize: DesignTokens.displayMediumSize,
            fontWeight: FontWeight.bold,
          ),
          headlineLarge: GoogleFonts.ibmPlexSansThai(
            fontSize: DesignTokens.headlineLargeSize,
            fontWeight: FontWeight.w600,
          ),
          labelLarge: GoogleFonts.ibmPlexSansThai(fontWeight: FontWeight.w500),
        ),
  );
}
