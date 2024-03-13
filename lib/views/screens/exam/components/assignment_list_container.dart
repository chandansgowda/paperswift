import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';
import 'package:paperswift/models/examination_detail.dart';
import 'package:paperswift/views/screens/dashboard/components/deletethis1.dart';

import '../../../../utils/constants.dart';


class AssignmentListContainer extends StatelessWidget {

  ExaminationDetailController examinationDetailController=Get.find<ExaminationDetailController>();
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
          Obx(() => SizedBox(
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
              ],
              rows: List.generate(
                examinationDetailController.examinationDetail.departments[examinationDetailController.currentDepartmentIndex.value].courses.length,
                    (index) => assignmentTile(examinationDetailController.examinationDetail.departments[examinationDetailController.currentDepartmentIndex.value].courses[index],index),
              ),
            ),
          ),)
        ],
      ),
    );
  }
}

DataRow assignmentTile(Course course,int courseIndex) {
  ExaminationDetailController examinationDetailController=Get.find<ExaminationDetailController>();
  return DataRow(
    cells: [
      DataCell(
        Text(course.name),
      ),
      DataCell(Text(course.code)),
      DataCell(InkWell(
        onTap: (){
          examinationDetailController.currentCourseIndex.value=courseIndex;
        },
        child: Container(
            decoration: BoxDecoration(
              color: examinationDetailController.currentCourseIndex.value==courseIndex?Colors.blue:Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.blue)
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(course.paperSetterName==""?"Select Paper Setter":course.paperSetterName.value),
            )),
  ),),
      DataCell(Text('NA')),
    ],
  );
}
