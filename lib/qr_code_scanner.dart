// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/employee_page.dart';
import 'package:flutter_application_1/student_page.dart';
import 'package:flutter_application_1/subject_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  var type;
  QRCodeScannerScreen({Key? key, required this.type}) : super(key: key);

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  void sendValues() {
    final parts = result!.code.toString().split(';');
    if (widget.type == 'student') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => StudentPage(
                  name: parts[0],
                  registration_number: parts[2],
                  course: parts[1],
                )),
      );
    } else if (widget.type == 'subject') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SubjectPage(
            file_number: parts[0],
            index_heading: parts[1],
          ),
        ),
      );
    } else if (widget.type == 'employee') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeePage(
            name: parts[0],
            department: parts[1],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                controller.scannedDataStream.listen((scanData) {
                  setState(() {
                    result = scanData;
                  });
                  sendValues();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    QRViewController qrController = qrKey.currentState as QRViewController;
    qrController.dispose();
  }
}
