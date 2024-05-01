import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/main_controller.dart';
import 'package:paperswift/controllers/qp_review_controller.dart';

import '../../../../models/question_paper_detail.dart';
import '../../../../utils/constants.dart';

class QuestionPaperDetailContainer extends StatelessWidget {
  QuestionPaperReviewController questionPaperReviewController=Get.find<QuestionPaperReviewController>();
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
          Text(
            "Assignment Table",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Obx(
                () => SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: defaultPadding,
                // minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text("Course name"),
                  ),
                  DataColumn(
                    label: Text("Course code"),
                  ),
                  DataColumn(
                    label: Text("Semester"),
                  ),
                  DataColumn(
                    label: Text("Assigned To"),
                  ),
                  DataColumn(
                    label: Text("Review"),
                  ),
                  DataColumn(
                    label: Text("Latest message"),
                  ),
                ],
                rows: List.generate(
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
            ),
          )
        ],
      ),
    );
  }
}

DataRow assignmentTile(BuildContext context,Course course, int courseIndex) {
  QuestionPaperReviewController questionPaperReviewController=Get.find<QuestionPaperReviewController>();
  return DataRow(
    cells: [
      DataCell(
        Text(course.name),
      ),
      DataCell(Text(course.code)),
      DataCell(Text("sem")),
      DataCell(Text(course.paperSetterName)),
      // DataCell(
      //   InkWell(
      //     onTap: () {
      //       // if(questionPaperDetailContainerassignmentStatus==0){
      //       //   questionPaperDetailContainer.currentCourseIndex.value = courseIndex;
      //       // }
      //     },
      //     child: Container(
      //         decoration: BoxDecoration(
      //             color:questionPaperReviewController.currentCourseIndex.value ==
      //                 courseIndex
      //                 ? Colors.blue
      //                 : Colors.transparent,
      //             borderRadius: BorderRadius.circular(5),
      //             border: Border.all(color: Colors.blue)),
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Text(course.paperSetterName.value == "NA"
      //               ? "Select Paper Setter"
      //               : course.paperSetterName.value),
      //         )),
      //   ),
      // ),
      DataCell(Text(course.status)),
      DataCell(Row(children: [Expanded(
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
              _showInputDialog(context,int.parse("7"),"paper['course_id']!","jsnfjsnf");
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
        SizedBox(height: 8),],)),
      DataCell(Text("Message")),
    ],
  );
}
void _showInputDialog(BuildContext context,int examId,String courseCode,String email) {
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
            onPressed: ()async {
              // Retrieve the input value
              String message = _textFieldController.text;

              // Perform any action with the input value (e.g., submit it)
              print('Submitted message: $message');
              var data=json.encode({
                "exam_id":examId,
                "tracking_token":"tracking",
                "course_code":courseCode,
                "email":email
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
