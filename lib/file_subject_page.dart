import 'package:flutter/material.dart';

class FileSubjectPage extends StatefulWidget {
  final List<FileDetails> fileDetailsList;

  const FileSubjectPage({Key? key, required this.fileDetailsList})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FileSubjectPageState createState() => _FileSubjectPageState();
}

class _FileSubjectPageState extends State<FileSubjectPage> {
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
    required String fileNo,
    required String indexHeadings,
    required String date,
    required String fromWhom,
    required String toWhom,
  }) {
    setState(() {
      final newFileDetails = FileDetails(
        fileNo: fileNo,
        indexHeadings: indexHeadings,
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
          const SizedBox(
              width: 16.0), // Add SizedBox to separate search icon from actions
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
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween, // Align columns
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              'File No',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              'Index Headings',
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
                          Expanded(
                            flex: 1,
                            child: SizedBox(), // Empty spacer for delete column
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
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Align columns
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    fileDetails.fileNo,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected ? Colors.blue : null,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(fileDetails.indexHeadings),
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
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        filteredFileDetailsList.removeAt(index);
                                        deletedFileIds.add(fileDetails.id!);
                                      });
                                    },
                                  ),
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

  _FileSearchDelegate({
    required this.fileDetailsList,
    required this.onFileSelected,
  });

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
            fileNo: '',
            indexHeadings: '',
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
        .where((fileDetails) => fileDetails.fileNo.contains(query))
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final fileDetails = filteredList[index];
        return ListTile(
          title: Text(
            fileDetails.indexHeadings,
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
        .where((fileDetails) => fileDetails.fileNo.contains(query))
        .toList();

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final fileDetails = filteredList[index];
        return ListTile(
          title: Text(
            fileDetails.fileNo,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          subtitle: Text(fileDetails.indexHeadings),
          onTap: () {
            query = fileDetails.fileNo;
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
  final String fileNo;
  final String indexHeadings;
  final String date;
  final String fromWhom;
  final String toWhom;

  FileDetails({
    this.id,
    required this.fileNo,
    required this.indexHeadings,
    required this.date,
    required this.fromWhom,
    required this.toWhom,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Storage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileSubjectPage(
        fileDetailsList: [
          FileDetails(
            id: 1,
            fileNo: '001',
            indexHeadings: 'Heading 1',
            date: '2022-01-01',
            fromWhom: 'John',
            toWhom: 'Alice',
          ),
          FileDetails(
            id: 2,
            fileNo: '002',
            indexHeadings: 'Heading 2',
            date: '2022-01-02',
            fromWhom: 'Bob',
            toWhom: 'Alice',
          ),
        ],
      ),
    );
  }
}
