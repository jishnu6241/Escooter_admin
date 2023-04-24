import 'package:escooter_admin/ui/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://rovptkqybifeaarerqky.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJvdnB0a3F5YmlmZWFhcmVycWt5Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY4MjMzMTE2NiwiZXhwIjoxOTk3OTA3MTY2fQ.InUQ6dpIMGo3wNlbqhPadV886Y3g8EYXgWmPeCTUnIc',
  );

  // Supabase.instance.client.auth.admin.createUser(
  //   AdminUserAttributes(
  //     email: 'admin@escooter.com',
  //     password: 'password',
  //     emailConfirm: true,
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Escooter Admin',
      theme: ThemeData.light().copyWith(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.greenAccent[100],
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          iconColor: Colors.greenAccent,
          prefixIconColor: Colors.greenAccent,
          suffixIconColor: Colors.greenAccent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
