import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final List<FileDetails> _fileList = []; // List to store file details

  String _fileNumber = '';
  String _dateIssued = '';
  String _toWhom = '';
  String _dateReturned = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Create a new FileDetails object
      final newFile = FileDetails(
        fileNumber: _fileNumber,
        dateIssued: _dateIssued,
        toWhom: _toWhom,
        dateReturned: _dateReturned,
      );

      setState(() {
        _fileList.add(newFile); // Add the new file to the list
      });

      _formKey.currentState!.reset(); // Reset the form
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Tracking System'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'File Details Form',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'File Number'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the file number.';
                      }
                      return null;
                    },
                    onSaved: (value) => _fileNumber = value!,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Date Issued'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the date issued.';
                      }
                      return null;
                    },
                    onSaved: (value) => _dateIssued = value!,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'To Whom'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the recipient.';
                      }
                      return null;
                    },
                    onSaved: (value) => _toWhom = value!,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Date Returned'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the date returned.';
                      }
                      return null;
                    },
                    onSaved: (value) => _dateReturned = value!,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32.0),
            Text(
              'File Details Table',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            DataTable(
              columns: const [
                DataColumn(label: Text('File Number')),
                DataColumn(label: Text('Date Issued')),
                DataColumn(label: Text('To Whom')),
                DataColumn(label: Text('Date Returned')),
              ],
              rows: _fileList.map((file) {
                return DataRow(cells: [
                  DataCell(Text(file.fileNumber)),
                  DataCell(Text(file.dateIssued)),
                  DataCell(Text(file.toWhom)),
                  DataCell(Text(file.dateReturned)),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class FileDetails {
  final String fileNumber;
  final String dateIssued;
  final String toWhom;
  final String dateReturned;

  FileDetails({
    required this.fileNumber,
    required this.dateIssued,
    required this.toWhom,
    required this.dateReturned,
  });
}
