import 'package:flutter/material.dart';

class FileEmployeePage extends StatefulWidget {
  final List<FileDetails> fileDetailsList;

  const FileEmployeePage({Key? key, required this.fileDetailsList})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FileEmployeePageState createState() => _FileEmployeePageState();
}

class _FileEmployeePageState extends State<FileEmployeePage> {
  late List<FileDetails> filteredFileDetailsList;
  late TextEditingController _searchController;
  FileDetails? selectedFile; // Track the selected file
  List<int> deletedFileIds = []; // Store the IDs of deleted files

  @override
  void initState() {
    super.initState();
    filteredFileDetailsList = widget.fileDetailsList;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void addFileDetails({
    required String employeeName,
    required String department,
    required String date,
    required String fromWhom,
    required String toWhom,
  }) {
    setState(() {
      final newFileDetails = FileDetails(
        employeeName: employeeName,
        department: department,
        date: date,
        fromWhom: fromWhom,
        toWhom: toWhom,
      );
      filteredFileDetailsList.add(newFileDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Storage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch<FileDetails>(
                context: context,
                delegate: _FileSearchDelegate(
                  fileDetailsList: widget.fileDetailsList,
                  onFileSelected: (fileDetails) {
                    setState(() {
                      selectedFile = fileDetails; // Update the selected file
                    });
                  },
                ),
              );
            },
          ),
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
        padding: const EdgeInsets.only(top: 8.0),
        child: Center(
          child: filteredFileDetailsList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Employee Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Department',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'Date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'From Whom',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              'To Whom',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredFileDetailsList.length,
                        itemBuilder: (context, index) {
                          final fileDetails = filteredFileDetailsList[index];
                          final isSelected = fileDetails == selectedFile;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    fileDetails.employeeName,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected ? Colors.blue : null,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(fileDetails.department),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(fileDetails.date),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(fileDetails.fromWhom),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(fileDetails.toWhom),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      filteredFileDetailsList.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const Center(child: Text('No file details available.')),
        ),
      ),
    );
  }
}

class _FileSearchDelegate extends SearchDelegate<FileDetails> {
  final List<FileDetails> fileDetailsList;
  final Function(FileDetails) onFileSelected;

  _FileSearchDelegate(
      {required this.fileDetailsList, required this.onFileSelected});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          FileDetails(
            employeeName: '',
            department: '',
            date: '',
            fromWhom: '',
            toWhom: '',
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredList = fileDetailsList
        .where((fileDetails) => fileDetails.employeeName.contains(query))
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final fileDetails = filteredList[index];
        return ListTile(
          title: Text(
            fileDetails.department,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          subtitle: Text(fileDetails.date),
          onTap: () {
            close(context, fileDetails);
            onFileSelected(fileDetails); // Notify the selected file
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredList = fileDetailsList
        .where((fileDetails) => fileDetails.employeeName.contains(query))
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final fileDetails = filteredList[index];
        return ListTile(
          title: Text(
            fileDetails.employeeName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          subtitle: Text(fileDetails.department),
          onTap: () {
            close(context, fileDetails);
            onFileSelected(fileDetails); // Notify the selected file
          },
        );
      },
    );
  }
}

class FileDetails {
  final int? id;
  final String employeeName;
  final String department;
  final String date;
  final String fromWhom;
  final String toWhom;

  FileDetails({
    this.id,
    required this.employeeName,
    required this.department,
    required this.date,
    required this.fromWhom,
    required this.toWhom,
  });
}
