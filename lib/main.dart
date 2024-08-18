import 'package:flutter/material.dart';
import 'package:myapp/features/authentication/screens/login_screen.dart'; // Import your login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPSC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(), // Set the login screen as the initial route
    );
  }
}
