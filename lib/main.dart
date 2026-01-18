import 'package:flutter/material.dart';
import 'pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Notes',
      theme: ThemeData(
        useMaterial3: true,

        // 🌸 WARNA UTAMA
        primaryColor: const Color(0xFFF8BBD0),
        scaffoldBackgroundColor: const Color(0xFFFFF0F5),

        // 🌸 APPBAR
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8BBD0),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),

        // 🌸 BUTTON
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF48FB1),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),

        // 🌸 INPUT
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),

        // 🌸 FAB
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFF48FB1),
          foregroundColor: Colors.white,
        ),
      ),

      home: SplashPage(),
    );
  }
}
