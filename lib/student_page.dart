// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'file_student_page.dart';

class StudentPage extends StatefulWidget {
  final String? name;
  final String? registration_number;
  final String? course;
  StudentPage(
      {Key? key,
      required this.name,
      required this.registration_number,
      required this.course})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _formKey = GlobalKey<FormState>();
  final List<FileDetails> _fileDetailsList = [];

  String _name = '';
  String _regNo = '';
  String _course = '';
  late String _date;
  String _fromWhom = '';
  String _toWhom = '';

  @override
  void initState() {
    super.initState();
    _name = widget.name ?? '';
    _regNo = widget.registration_number ?? '';
    _course = widget.course ?? '';
    _date = DateTime.now().toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Tracking System'),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Student Details Form',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _name,
                      decoration: const InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the name.';
                        }
                        return null;
                      },
                      onSaved: (value) => _name = value!,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      initialValue: _regNo,
                      decoration: const InputDecoration(labelText: 'Reg No'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the registration number.';
                        }
                        if (!RegExp(r'^\d{5}/[A-Z]\.\d{4}$').hasMatch(value)) {
                          return 'Invalid registration number format. Please use the format "25721/T.2020".';
                        }
                        return null;
                      },
                      onSaved: (value) => _regNo = value!,
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Course'),
                      value: _course,
                      items: const [
                        DropdownMenuItem(
                          value: 'CSN',
                          child: Text('CSN'),
                        ),
                        DropdownMenuItem(
                          value: 'ISM',
                          child: Text('ISM'),
                        ),
                        DropdownMenuItem(
                          value: 'HIP',
                          child: Text('HIP'),
                        ),
                        DropdownMenuItem(
                          value: 'URP',
                          child: Text('URP'),
                        ),
                        DropdownMenuItem(
                          value: 'RDP',
                          child: Text('RDP'),
                        ),
                        DropdownMenuItem(
                          value: 'QS',
                          child: Text('QS'),
                        ),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a course.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _course = value!;
                        });
                      },
                      onSaved: (value) {
                        _course = value!;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Date'),
                      readOnly: false,
                      initialValue: _date,
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
                            name: _name,
                            regNo: _regNo,
                            course: _course,
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
                            builder: (context) => FileStudentPage(
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
