import 'package:flutter/material.dart';
import 'package:flutter_application_1/student_page.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;

  void sendValues() {
    final parts = result!.code.toString().split(';');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => StudentPage(
                name: parts[0],
                registration_number: parts[2],
                course: parts[1],
              )),
    );
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
