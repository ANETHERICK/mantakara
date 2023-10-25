import 'package:flutter/material.dart';
import 'file_employee_page.dart';

class EmployeePage extends StatefulWidget {
  final String? name;
  final String? department;
  const EmployeePage({Key? key, required this.name, required this.department})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<EmployeePage> {
  final _formKey = GlobalKey<FormState>();
  final List<FileDetails> _fileDetailsList = [];

  String _employeeName = '';
  String _department = 'CSM';
  late String _date;
  String _fromWhom = '';
  String _toWhom = '';

  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateTime.now().toString().split(' ')[0];
    print(widget.name);
    print(widget.department);
    _date = _dateController.text;
    _employeeName = widget.name ?? '';
    _department = widget.department ?? '';
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
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
          // Add SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Employee Details Form',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _employeeName,
                      decoration:
                          const InputDecoration(labelText: 'Employee Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the employee name.';
                        }
                        return null;
                      },
                      onSaved: (value) => _employeeName = value!,
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(labelText: 'Department'),
                      value: _department,
                      items: const ['CSM', 'URP'].map((String department) {
                        return DropdownMenuItem<String>(
                          value: department,
                          child: Text(department),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _department = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a department.';
                        }
                        return null;
                      },
                      onSaved: (value) => _department = value!,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Date'),
                      readOnly: true,
                      controller: _dateController,
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            setState(() {
                              _dateController.text =
                                  selectedDate.toString().split(' ')[0];
                              _date = _dateController.text;
                            });
                          }
                        });
                      },
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
                            employeeName: _employeeName,
                            department: _department,
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
                            builder: (context) => FileEmployeePage(
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
