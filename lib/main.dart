import 'package:flutter/material.dart';
import 'package:lista_afazeres/screens/home.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.purple.shade700, foregroundColor: Colors.white),
        colorScheme: const ColorScheme.dark()
      ),
      home: Home(),
    );
  }
}

