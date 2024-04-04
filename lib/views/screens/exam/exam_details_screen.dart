import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';
import 'package:paperswift/controllers/main_controller.dart';
import 'package:paperswift/services/api_service.dart';
import 'package:paperswift/views/screens/dashboard/components/storage_details.dart';
import 'package:paperswift/views/screens/exam/components/teachers_list_container.dart';
import 'package:paperswift/views/screens/exam/components/assignment_list_container.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';

class ExamDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    ExaminationDetailController examinationDetailController=Get.find<ExaminationDetailController>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  //TODO:Object can be reset
                  examinationDetailController.currentCourseIndex.value=500;
                  examinationDetailController.currentDepartmentIndex.value=0;
                  Get.close(1);
                },
                icon: Icon(Icons.close),
              ),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Exam title",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 1.5,
                                      vertical: defaultPadding /
                                          (Responsive.isMobile(context)
                                              ? 2
                                              : 1),
                                    ),
                                  ),
                                  onPressed: () async{
                                    var assignments=[];
                                    assignments.addAll(examinationDetailController.examinationDetail.departments.expand((department) => department.courses.map((course) {
                                      if(course.paperSetterName.value!="NA" &&( course.status=="Invite Rejected" || course.status=="NA")) {
                                        return {"course_code":course.code,"paper_setter_id":course.paperSetterId};
                                      }
                                    })));
                                    assignments.removeWhere((element) => element==null);
                                    if(assignments.isNotEmpty){
                                      var data=json.encode({
                                        "exam_id":examinationDetailController.examinationId,
                                        "assignments":assignments
                                      });
                                      print(data);
                                      await Get.find<MainController>().api.postBulkPaperSetters(data);
                                      //TODO:Catch the error and display proper message
                                    }
                                  },
                                  child: Text("Submit"),
                                ),
                              ],
                            ),
                            SizedBox(height: defaultPadding),
                            Responsive(
                              mobile: DepartmentTileGridView(
                                crossAxisCount: _size.width < 650 ? 2 : 4,
                                childAspectRatio: _size.width < 650 ? 1.3 : 1,
                              ),
                              tablet: DepartmentTileGridView(),
                              desktop: DepartmentTileGridView(
                                childAspectRatio: 4,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: defaultPadding),
                        AssignmentListContainer(),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) StorageDetails(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we don't want to show it
                  if (!Responsive.isMobile(context))
                    Expanded(
                      flex: 2,
                      child: TeachersListContainer(),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DepartmentTileGridView extends StatelessWidget {
  DepartmentTileGridView({
    Key? key,
    this.crossAxisCount = 5,
    this.childAspectRatio = 0.5,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  ExaminationDetailController examinationDetailController =
      Get.find<ExaminationDetailController>();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount:
            examinationDetailController.examinationDetail.departments.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) => InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
              onTap: () {
                examinationDetailController.currentDepartmentIndex.value =
                    index;
                examinationDetailController.currentCourseIndex.value=500;
              },
              child: Obx(() => DepartmentTile(
                  title: examinationDetailController
                      .examinationDetail.departments[index].name,
                  bgColor: examinationDetailController
                              .currentDepartmentIndex.value ==
                          index
                      ? primaryColor
                      : secondaryColor)),
            ));
  }
}

class DepartmentTile extends StatelessWidget {
  final String title;
  final Color bgColor;

  DepartmentTile({super.key, required this.title, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(child: Text(title)));
  }
}
