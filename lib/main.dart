import 'package:escooter_admin/ui/screen/home_screen_sections/dashboard.dart';
import 'package:escooter_admin/ui/screen/home_screen_sections/scooter_management.dart';
import 'package:escooter_admin/ui/screen/homepage.dart';
import 'package:escooter_admin/ui/screen/hub_management.dart';
import 'package:escooter_admin/ui/screen/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
