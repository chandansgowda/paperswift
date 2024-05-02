import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/main_controller.dart';
import 'package:paperswift/controllers/qp_review_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/question_paper_detail.dart';
import '../../../../utils/constants.dart';

class QuestionPaperDetailContainer extends StatelessWidget {
  QuestionPaperReviewController questionPaperReviewController =
      Get.find<QuestionPaperReviewController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(child: Text("Course name")),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(child: Text("Course code")),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(child: Text("Status")),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text("Assigned to")),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(child: Text("Latest review")),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(child: Text("Review")),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(child: Text("Download")),
                  ),
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Column(
                children: List.generate(
                  questionPaperReviewController
                      .questionPaperDetail
                      .departments[questionPaperReviewController
                          .currentDepartmentIndex.value]
                      .courses
                      .length,
                  (index) => assignmentTile(
                      context,
                      questionPaperReviewController
                          .questionPaperDetail
                          .departments[questionPaperReviewController
                              .currentDepartmentIndex.value]
                          .courses[index],
                      index),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Row assignmentTile(BuildContext context, Course course, int courseIndex) {
  Future<void> launchLink(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }

  return Row(
    children: [
      Expanded(
        flex: 3,
        child: Center(
          child: Text(course.name),
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text(course.code),
        ),
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: Text(course.status),
        ),
      ),
      Expanded(
        flex: 2,
        child: Center(
          child: Text(course.paperSetterName),
        ),
      ),
      Expanded(
        flex: 2,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white60),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Text(
                        "Message wdnwd wdnwodniowd wjdnwonxkw xwqxmwqoidnwqx wqkkxnoqwkndkwq dm,qwx kwqkdnkwoqdn",
                    textAlign: TextAlign.center,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 3,
        child: Center(
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Accept'),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    _showInputDialog(context, int.parse("7"),
                        "paper['course_id']!", "jsnfjsnf");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Review'),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Expanded(
        flex: 1,
        child: Center(
          child: GestureDetector(
            onTap: () async {
              await launchLink(course.qpDocUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(Icons.download),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

void _showInputDialog(
    BuildContext context, int examId, String courseCode, String email) {
  TextEditingController _textFieldController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Enter Message'),
        content: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: 'Enter your message'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text('Submit'),
            onPressed: () async {
              // Retrieve the input value
              String message = _textFieldController.text;

              // Perform any action with the input value (e.g., submit it)
              print('Submitted message: $message');
              var data = json.encode({
                "exam_id": examId,
                "tracking_token": "tracking",
                "course_code": courseCode,
                "email": email
              });
              print(data);
              //TODO:write function to post comment
              // await Get.find<MainController>().api.postBulkPaperSetters(data);
              // Close the dialog
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
