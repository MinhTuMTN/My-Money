import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  
  // Light Theme (your original theme with minor adjustments for clarity)
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF429690),
      brightness: Brightness.light,
      primary: const Color(0xFF3D74B6), // Your primary blue
      onPrimary: Colors.white, // Text on primary
      surface: const Color(0xFFFDFDFD), // Light background for cards, sheets etc.
      onSurface: const Color.fromARGB(255, 0, 0, 0), // Text on surface (black)
      inverseSurface: const Color(0xFF1B5C58), // Used for inverted surfaces
      surfaceContainer: const Color(0xFF429690),
      onInverseSurface: Colors.white // A lighter shade for containers/cards
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 255, 117, 117), // Your desired status bar color
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark, // Dark icons on light background
        statusBarBrightness: Brightness.light, // For iOS and consistency
      ),
    ),
  );

  // Dark Theme (newly created)
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF429690), // Consistent seed color
      brightness: Brightness.dark, // Crucial for dark theme
      primary: const Color(0xFF90CAF9), // A lighter primary for dark mode (e.g., Light Blue)
      onPrimary: Colors.black, // Text on primary for dark mode (contrast with light primary)
      surface: const Color(0xFF0F1B26), // Dark background for cards, sheets etc.
      onSurface: Colors.white, // Text on surface (white)
      inverseSurface: const Color(0xFF429690), // Used for inverted surfaces (can be original primary)
      surfaceContainer: const Color(0xFF429690), // A darker shade for containers/cards
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 139, 0, 0), // Darker red for dark mode app bar
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light, // Light icons on dark background
        statusBarBrightness: Brightness.dark, // For iOS and consistency
      ),
    ),
  );
}