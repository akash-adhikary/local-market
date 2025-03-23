import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ojzshfxdgilfyvxzxeoi.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qenNoZnhkZ2lsZnl2eHp4ZW9pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI1NDMxMTUsImV4cCI6MjA1ODExOTExNX0.4SWCnoMwXM92ztPoBQ-pqXCzKy2y36xEHJT_Daetq1Q',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
