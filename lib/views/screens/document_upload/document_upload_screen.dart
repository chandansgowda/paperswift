import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:paperswift/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Upload',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DocumentUploadScreen(),
    );
  }
}

class DocumentUploadScreen extends StatefulWidget {
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  String _filePath='';

  void _openFileExplorer() async {
    try {
      // Open file explorer
      var file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );
      String? filePath=file!.files.single.path;

      if (filePath != null) {
        setState(() {
          _filePath = filePath;
        });
      }
    } catch (e) {
      print("Error while picking the file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {'course_code': 'CSE101', 'subject_name': 'Introduction to Computer Science', 'semester': '1'},
      {'course_code': 'MTH201', 'subject_name': 'Linear Algebra', 'semester': '2'},
      {'course_code': 'ENG301', 'subject_name': 'English Composition', 'semester': '3'},
      // Add more data as needed
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Document'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Course Code')),
                    DataColumn(label: Text('Subject Name')),
                    DataColumn(label: Text('Semester')),
                  ],
                  rows: data
                      .map(
                        (item) => DataRow(
                      cells: [
                        DataCell(Text(item['course_code']!)),
                        DataCell(Text(item['subject_name']!)),
                        DataCell(Text(item['semester']!)),
                      ],
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 50,),
            GestureDetector(
              onTap: _openFileExplorer,
              child: Container(
                  height: 100,
                  width: 500,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload),
                      SizedBox(width: 20,),
                      Text('UPLOAD DOCUMENT'),
                    ],
                  ))),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: (){

              },
              child: Container(
                  height: 50,
                  width: 500,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(child:Text('SUBMIT'), )),
            ),
          ],
        ),
      ),
    );
  }
}

