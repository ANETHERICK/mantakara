import 'package:flutter/material.dart';
import 'package:flutter_application_1/qr_code_scanner.dart';
// import 'student_page.dart';
import 'employee_page.dart';
import 'subject_page.dart';

class HomePage extends StatelessWidget {
  final String username; // Add a username parameter to the constructor

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FILE TRACKING SYSTEM'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'CHOOSE THE TYPE OF FILE', // Display the username
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
<<<<<<< HEAD
                      builder: (context) => const QRCodeScannerScreen(),
=======
                      builder: (context) =>  QRCodeScannerScreen(type: 'student',),
>>>>>>> 85fa2dc91d27f55e91f1ee1588282587eb5f3c39
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.all(24.0),
                ),
                child: const Text(
                  "Student's File",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  QRCodeScannerScreen(type: 'subject',),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.all(24.0),
                ),
                child: const Text(
                  "Subject's File",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  QRCodeScannerScreen(type: 'employee',),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  padding: const EdgeInsets.all(24.0),
                ),
                child: const Text(
                  "Employee's File",
                  style: TextStyle(fontSize: 30.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
