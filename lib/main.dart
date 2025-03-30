import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

void main() {
  runApp(const TextileInventoryApp());
}

class TextileInventoryApp extends StatelessWidget {
  const TextileInventoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextilePro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const DashboardScreen(),
    );
  }
}