import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:paperswift/utils/constants.dart';
import 'dart:html' as html;

class DocumentUploadScreen extends StatefulWidget {
  @override
  _DocumentUploadScreenState createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  FilePickerResult? result;
  String fileName = "";

  void _openFileExplorer() async {
    try {
      // Open file explorer
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'zip'],
      );
      setState(() {
        fileName = result!.names[0]!;
      });
    } catch (e) {
      print("Error while picking the file: $e");
    }
  }

  void _submitDocument(String courseCode, int examId, String token) async {
    if (result != null) {
      final dio = Dio();
      List<int> fileBytes = result!.files.single.bytes as List<int>;
      final formData = FormData.fromMap({
        'name': 'dio',
        'date': DateTime.now().toIso8601String(),
        'exam_id': 15,
        'course_code': '20CS710',
        'tracking_token': token,
        // 'tracking_token':,
        'file': MultipartFile.fromBytes(
          fileBytes,
          filename: "fileName",
        ),
      });
      final response = await dio.post(
          'https://paperswiftsjcetest.pythonanywhere.com/assignment/upload_question_paper',
          data: formData);
      print(formData);
      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('Failed to upload file. Error: ${response}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    Uri uri = Uri.parse(html.window.location.href);
    String fragment = uri.fragment;

    // Split the fragment to separate path and query parameters
    List<String> parts = fragment.split('?');

    // Extract the path and query parameters
    String path = parts[0]; // This should be "/upload-qp"
    String queryParamsString = parts.length > 1 ? parts[1] : '';

    // Parse the query parameters
    Map<String, String> queryParams = {};
    if (queryParamsString.isNotEmpty) {
      List<String> pairs = queryParamsString.split('&');
      for (String pair in pairs) {
        List<String> keyValue = pair.split('=');
        if (keyValue.length == 2) {
          String key = Uri.decodeComponent(keyValue[0]);
          String value = Uri.decodeComponent(keyValue[1]);
          queryParams[key] = value;
        }
      }
    }
    String course_code=queryParams['course_code']!;
    String course_name=queryParams['course_name']!;
    String exam_id=queryParams['exam_id']!;
    String token=queryParams['tracking_token']!;
    String sem=queryParams['sem']!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Document'),
        centerTitle: true,
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
                  rows: [DataRow(
                          cells: [
                            DataCell(Text(course_code)),
                            DataCell(
                                Text(course_name.replaceAll(" + ", " "))),
                            DataCell(Text(sem)),
                          ],
                        ),]
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            if (fileName != "")
              Column(
                children: [
                  Container(
                    height: 50,
                    width: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white)),
                    child: Center(
                      child: Text("Selected file name : " + fileName),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            GestureDetector(
              onTap: _openFileExplorer,
              child: Container(
                  height: 100,
                  width: 500,
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.upload),
                      SizedBox(
                        width: 20,
                      ),
                      Text('UPLOAD DOCUMENT'),
                    ],
                  ))),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _submitDocument(course_code, int.parse(exam_id), token);
                // window.close();
              },
              child: Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text('SUBMIT'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
