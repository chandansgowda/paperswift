import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';
import 'package:paperswift/views/screens/exam/components/teacher_tile.dart';

import '../../../../utils/constants.dart';

class TeachersListContainer extends StatelessWidget {
  ExaminationDetailController examinationDetailController=Get.find<ExaminationDetailController>();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Obx((){
        late List<TeacherTile> teacherTiles;

        try {
          var selectedCourse = examinationDetailController.examinationDetail.departments[examinationDetailController.currentDepartmentIndex.value].courses.firstWhere(
                (element) => element.code == examinationDetailController.currentCourseCode.value,
          );

          // If the course is found, map its paper setters to TeacherTiles
          teacherTiles = selectedCourse.paperSetters.map((paperSetter) =>
              TeacherTile(name: paperSetter.name, qualification: paperSetter.qualification, id: paperSetter.id)
          ).toList();
        } catch (e) {
          // If no course is found, handle the error by setting an empty list of TeacherTiles
          teacherTiles = [];
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Teachers List",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            if(teacherTiles.isNotEmpty)...teacherTiles.map((teacher) => TeacherTile(name: teacher.name, qualification: teacher.qualification, id: teacher.id))
            else SizedBox(
                width: double.infinity,
                height: 60,
                child: Center(child: Text(examinationDetailController.currentCourseCode.value==""?"No course is selected":'No paper setters for selected course')))
          ],
        );
      }),
    );
  }
}
