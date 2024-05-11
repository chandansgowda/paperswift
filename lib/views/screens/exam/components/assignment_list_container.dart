import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';
import 'package:paperswift/controllers/main_controller.dart';
import 'package:paperswift/models/examination_detail.dart';
import 'package:paperswift/views/screens/dashboard/components/deletethis1.dart';

import '../../../../utils/constants.dart';

class AssignmentListContainer extends StatelessWidget {
  ExaminationDetailController examinationDetailController =
      Get.find<ExaminationDetailController>();
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
          examinationDetailController.examinationDetail.departments.isEmpty?Center(child: Text("No data"),):Obx(
            () => SizedBox(
              width: double.infinity,
              child: DataTable(
                columnSpacing: defaultPadding,
                // minWidth: 600,
                columns: [
                  DataColumn(
                    label: Text("Subject Name"),
                  ),
                  DataColumn(
                    label: Text("Subject Code"),
                  ),
                  DataColumn(
                    label: Text("Assigned To"),
                  ),
                  DataColumn(
                    label: Text("Status"),
                  ),
                  if(examinationDetailController.examinationDetail.assignmentStatus != 0)DataColumn(
                    label: Text("Options"),
                  ),

                ],
                rows: List.generate(
                  examinationDetailController
                      .examinationDetail
                      .departments[examinationDetailController
                          .currentDepartmentIndex.value]
                      .courses
                      .length,
                  (index) => assignmentTile(
                      examinationDetailController
                          .examinationDetail
                          .departments[examinationDetailController
                              .currentDepartmentIndex.value]
                          .courses[index],
                      index),
                ),
              ),
            ),),
        ],
      ),
    );
  }
}

DataRow assignmentTile(Course course, int courseIndex) {
  ExaminationDetailController examinationDetailController =
      Get.find<ExaminationDetailController>();
  return DataRow(
    cells: [
      DataCell(
        Text(course.name),
      ),
      DataCell(Text(course.code)),
      DataCell(
        InkWell(
          onTap: () {
            if(examinationDetailController.examinationDetail.assignmentStatus==0){
              examinationDetailController.currentCourseIndex.value = courseIndex;
              examinationDetailController.currentCourseCode.value=course.code;
            }
          },
          child: Container(
              decoration: BoxDecoration(
                  color: examinationDetailController.currentCourseIndex.value ==
                          courseIndex
                      ? Colors.blue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.blue)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(course.paperSetterName.value == "NA"
                    ? "Select Paper Setter"
                    : course.paperSetterName.value),
              )),
        ),
      ),
      DataCell(Text(course.status)),
      if(examinationDetailController.examinationDetail.assignmentStatus != 0)DataCell(PopupMenuButton<int>(
        itemBuilder: (context) => [
          // PopupMenuItem 1
          PopupMenuItem(
            onTap:  () {
              if(course.status!="Invite Rejected" && course.status!="NA"){
                Get.snackbar("title", "You can't edit it");
              }
              else{
                examinationDetailController.currentCourseIndex.value = courseIndex;
                examinationDetailController.currentCourseCode.value = course.code;
              }
            },
            value: 1,
            // row with 2 children
            child: Row(
              children: [
                Icon(Icons.edit),
                SizedBox(
                  width: 10,
                ),
                Text("Edit")
              ],
            ),
          ),
          // PopupMenuItem 2
          if(course.status=="Request Pending" || course.status=="In Progress")PopupMenuItem(
            onTap: () async {
              var data=json.encode({
                "assignment_id":course.assignmentId
              });
              var response=await Get.find<MainController>().api.sendReminder(data);
              if(response==200){
                Get.snackbar("Mail sent", "The reminder mail sent");
              }
            },
            value: 2,
            // row with two children
            child: Row(
              children: [
                Icon(Icons.loop),
                SizedBox(
                  width: 10,
                ),
                Text("Remind")
              ],
            ),
          ),
        ],
      ),),
    ],
  );
}
