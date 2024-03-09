import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paperswift/controllers/exam_controller.dart';
import 'package:paperswift/views/screens/dashboard/components/examination_tile.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/responsive.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  MyFiles({
    Key? key,
  }) : super(key: key);
  ExamController examController = Get.put(ExamController());
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Examinations",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical:
                      defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Container(
                          width: Get.size.width * 0.3,
                          decoration: BoxDecoration(
                              color: bgColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Material(
                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "New Examination",
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Degree"),
                                        DropdownButton(
                                            value: [
                                              'BE',
                                              'BCA',
                                            ][0],
                                            items: ['BE', 'BCA']
                                                .map((course) => DropdownMenuItem(
                                                    value: course,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(course),
                                                    )))
                                                .toList(),
                                            onChanged: (newValue) {
                                              //TODO:Set the course
                                            })
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Scheme"),
                                        DropdownButton(
                                            value: ['2020', '2022', '2024'][0],
                                            items: ['2020', '2022', '2024']
                                                .map((scheme) => DropdownMenuItem(
                                                    value: scheme,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(scheme),
                                                    )))
                                                .toList(),
                                            onChanged: (newValue) {
                                              //TODO:Set the scheme
                                            })
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Type"),
                                        DropdownButton(
                                            value: ['Regular','Supplementary'][0],
                                            items: ['Regular','Supplementary']
                                                .map((scheme) => DropdownMenuItem(
                                                value: scheme,
                                                child: Text(scheme)))
                                                .toList(),
                                            onChanged: (newValue) {
                                              //TODO:Set the scheme
                                            })
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Deadline"),
                                        Row(
                                          children: [
                                            //TODO:Update the date
                                            Text("Date"),
                                            IconButton(onPressed: (){
                                              showDatePicker(context: context,
                                                firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                                                lastDate: DateTime(DateTime.now().year+1,DateTime.now().month,DateTime.now().day),);
                                            }, icon: Icon(Icons.calendar_month_outlined)),
                                          ],
                                        )
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding:EdgeInsets.symmetric(vertical: 6,horizontal: 40),
                                        child: Text('CREATE'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.add),
              label: Text("Add New Exam"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  ExamController examController = Get.find<ExamController>();
  @override
  Widget build(BuildContext context) {
    List Exams = [
      {
        'name': '5',
        'type': 'Supplementary',
        'Date': '22/03/23',
        'degree': 'BE'
      },
      {'name': '7', 'type': 'Regular', 'Date': '12/03/23', 'degree': 'BCA'},
    ];
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: examController.exams.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: childAspectRatio,
        ),
        itemBuilder: (context, index) => Obx(
              () => ExaminationTile(
                title: examController.exams[index].sem.toString(),
                examType: examController.exams[index].isSupplementary
                    ? "Supplementary"
                    : "Regular",
                date: DateFormat('yyyy-MM-DD').format(
                    examController.exams[index].paperSubmissionDeadline),
                degree: examController.exams[index].degree,
              ),
            ));
  }
}
