import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';
import 'package:paperswift/views/screens/dashboard/components/chart.dart';
import 'package:paperswift/views/screens/dashboard/components/storage_info_card.dart';
import 'package:paperswift/views/screens/exam/components/teacher_tile.dart';

import '../../../../utils/constants.dart';

class TeachersListContainer extends StatelessWidget {
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
              "Teachers List",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            ...examinationDetailController.examinationDetail.departments[examinationDetailController.currentDepartmentIndex.value].paperSetters.map((paperSetter) => TeacherTile(name: paperSetter.name,qualification: paperSetter.qualification,)).toList(),
          ],
      ),
    );
  }
}
