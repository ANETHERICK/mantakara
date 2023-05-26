import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_page.dart';
import 'password_recovery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(),
        '/password_recovery': (context) => const PasswordRecoveryScreen(),
      },
    );
  }
}
