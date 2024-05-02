import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/exam_controller.dart';
import 'package:paperswift/models/examination.dart';

import '../../../../utils/constants.dart';
import 'deletethis1.dart';


class PreviousExams extends StatelessWidget {
  ExamController examController=Get.find<ExamController>();
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
            "History",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Obx(()
            {List<Examination> previousExams = [];
            for (var element in examController.exams) {
              if (element.isExamCompleted) {
                previousExams.add(element);
              }
            }
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Examination"),
                    ),
                    DataColumn(
                      label: Text("Degree"),
                    ),
                    DataColumn(
                      label: Text("Date"),
                    ),
                  ],
                  rows: List.generate(
                    previousExams.length,
                    (index) => recentFileDataRow(previousExams[index]),
                  ),
                );
              },),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(Examination fileInfo) {
  return DataRow(
    cells: [
      DataCell(
        Text("${fileInfo.sem} - Sem ${fileInfo.isSupplementary?"Supplementary":"Regular"}"),
      ),
      DataCell(Text(fileInfo.degree!)),
      DataCell(Text("${fileInfo.paperSubmissionDeadline.day}-${fileInfo.paperSubmissionDeadline.month}-${fileInfo.paperSubmissionDeadline.year}")),
    ],
  );
}
