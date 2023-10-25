// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'file_subject_page.dart';

class SubjectPage extends StatefulWidget {
  final String? file_number;
  final String? index_heading;
  const SubjectPage(
      {Key? key, required this.file_number, required this.index_heading})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SubjectPage> {
  final _formKey = GlobalKey<FormState>();
  final List<FileDetails> _fileDetailsList = [];

  String _fileNo = '';
  String _indexHeadings = '';
  late String _date;
  String _fromWhom = '';
  String _toWhom = '';

  @override
  void initState() {
    super.initState();
    print(widget.file_number);
    print(widget.index_heading);
    _fileNo = widget.file_number ?? '';
    _indexHeadings = widget.index_heading ?? '';
    _date = DateTime.now().toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file_number.toString()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Add SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Subject Details Form',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _fileNo,
                      decoration: const InputDecoration(labelText: 'File No'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the File No.';
                        }
                        return null;
                      },
                      onSaved: (value) => _fileNo = value!,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: _indexHeadings,
                      decoration:
                          const InputDecoration(labelText: 'Index Headings'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Index Headings.';
                        }
                        return null;
                      },
                      onSaved: (value) => _indexHeadings = value!,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Date'),
                      readOnly: true,
                      initialValue: DateTime.now().toString().split(' ')[0],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the date.';
                        }
                        return null;
                      },
                      onSaved: (value) => _date = value!,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'From Whom'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the source of the file.';
                        }
                        return null;
                      },
                      onSaved: (value) => _fromWhom = value!,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'To Whom'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the destination of the file.';
                        }
                        return null;
                      },
                      onSaved: (value) => _toWhom = value!,
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          _fileDetailsList.add(FileDetails(
                            fileNo: _fileNo,
                            indexHeadings: _indexHeadings,
                            date: _date,
                            fromWhom: _fromWhom,
                            toWhom: _toWhom,
                          ));

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form submitted successfully!'),
                            ),
                          );

                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FileSubjectPage(
                              fileDetailsList: _fileDetailsList,
                            ),
                          ),
                        );
                      },
                      child: const Text('View Files'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
