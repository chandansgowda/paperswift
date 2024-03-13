import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';

import '../../../../utils/constants.dart';


class TeacherTile extends StatelessWidget {
  TeacherTile({
    Key? key,
    required this.name,
    required this.qualification,
    required this.id
  }) : super(key: key);

  final String name;
  final String qualification;
  final int id;

  ExaminationDetailController examinationDetailController=Get.find<ExaminationDetailController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(examinationDetailController.currentCourseIndex.value!=500){
          examinationDetailController.examinationDetail.departments[examinationDetailController.currentDepartmentIndex.value].courses[examinationDetailController.currentCourseIndex.value].paperSetterName.value=name;
          examinationDetailController.examinationDetail.departments[examinationDetailController.currentDepartmentIndex.value].courses[examinationDetailController.currentCourseIndex.value].paperSetterId=id;
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: defaultPadding),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
          borderRadius: const BorderRadius.all(
            Radius.circular(defaultPadding),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(qualification)
          ],
        ),
      ),
    );
  }
}
