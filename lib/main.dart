import 'package:flutter/material.dart';
import 'package:portafolio/theme/app_theme.dart';
import 'package:portafolio/ui/home_page.dart';

void main() {
  runApp(const PortafolioApp());
}

class PortafolioApp extends StatelessWidget {
  const PortafolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Benjamin Ramirez | Software Developer',
      theme: AppTheme.darkTheme(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
