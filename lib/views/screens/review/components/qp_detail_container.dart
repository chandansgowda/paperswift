import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';
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
    return GetBuilder<QuestionPaperReviewController>(
      builder: (controller) {
        return Obx((){
          return questionPaperReviewController.isLoading.value?SizedBox(
            height: Get.height*0.75,
            child: CircularProgressIndicator(),):controller
              .questionPaperDetail
              .departments[controller
              .currentDepartmentIndex.value]
              .courses.isEmpty?Center(child: Text("No data 1")):Container(
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
                        controller
                            .questionPaperDetail
                            .departments[controller
                            .currentDepartmentIndex.value]
                            .courses
                            .length,
                            (index) => assignmentTile(
                            context,
                            controller.questionPaperDetail
                                .departments[controller
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
;
        });}
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
  ExaminationDetailController examinationDetailController=Get.find<ExaminationDetailController>();

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
                        course.message,
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
                child: GestureDetector(
                  onTap: () {
                    var data = json.encode({
                      "exam_id": examinationDetailController.examinationId,
                      "tracking_token": course.trackingToken,
                      "course_code": course.code
                    });
                    if(course.status=="Submitted"){
                      showDialog(context: context, builder: (BuildContext context){
                        return AlertDialog(title: Text("Are you sure?"),
                        content: Text("Confirm before accepting the document"),
                        actions: [
                          ElevatedButton(onPressed: (){
                            Get.back();
                          }, child: Text("Cancel"),),
                          ElevatedButton(onPressed: ()async{
                            Get.back();
                            await Get.find<MainController>().api.acceptPaper(data);
                            await Get.find<QuestionPaperReviewController>().fetchData(examinationDetailController.examinationId);
                          }, child: Text("Accept"))
                        ],);
                      });
                    }
                    else{
                      Get.snackbar("Can't be accepted", "The paper is not in submitted state");
                    }
                  },
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
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    _showInputDialog(context, examinationDetailController.examinationId,
                        course.code, "admin@admin.com",course.trackingToken);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Comment'),
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
              if(course.qpDocUrl=="NA"){
                Get.snackbar("Can't access", "The document is not yet uploaded");
              }
              else{
                await launchLink(course.qpDocUrl);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Icon(Icons.remove_red_eye_outlined),
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
    BuildContext context, int examId, String courseCode, String email,String trackingToken) {
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
                "tracking_token": trackingToken,
                "course_code": courseCode,
                "email": email,
                "comment":message
              });
              print(data);
              //TODO:write function to post comment
              await Get.find<MainController>().api.postComment(data);
              await Get.find<QuestionPaperReviewController>().fetchData(examId);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
