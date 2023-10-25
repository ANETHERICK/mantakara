import 'package:flutter/material.dart';
import 'home_page.dart';
import 'login_screen.dart';
import 'password_recovery.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // NFCHandler.handleNFCNavigation().then((nfcData) {
    //   // Handle the result of NFC detection
    //   if (nfcData.isSuccessful) {
    //     Navigator.pushNamed(context, '/login'); // Navigate to login screen
    //   } else {
    //     Navigator.pushNamed(context, '/'); // Navigate to default screen
    //   }
    // }).catchError((error) {
    //   // Handle NFC error
    //   logger.e('Error reading NFC: $error');
    //   Navigator.pushNamed(context, '/'); // Navigate to default screen
    // });

    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomePage(
              username: '',
            ),
        '/password_recovery': (context) => const PasswordRecoveryScreen(),
        '/login': (context) => const LoginScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      },
    );
  }
}
