import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:paperswift/controllers/degree_detail_controller.dart';
import 'package:paperswift/controllers/exam_controller.dart';
import 'package:paperswift/controllers/main_controller.dart';
import 'package:paperswift/services/api_service.dart';
import 'package:paperswift/views/screens/dashboard/components/examination_tile.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/responsive.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  MyFiles({
    Key? key,
  }) : super(key: key);
  ExamController examController = Get.put(ExamController());
  DegreesDetailsController degreesDetailsController=Get.put(DegreesDetailsController());
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
                                       Obx(() =>  DropdownButton(
                                           value:degreesDetailsController.selectedDegree.value,
                                           items: degreesDetailsController.degreesDetail.degrees.map((e) => e.name).toList()
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
                                             degreesDetailsController.selectedDegree.value=newValue!;
                                           }))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Scheme"),
                                        Obx(() => DropdownButton(
                                            value: degreesDetailsController.selectedScheme.toString(),
                                            items: degreesDetailsController.degreesDetail.degrees[degreesDetailsController.degreesDetail.degrees.indexWhere((element) => element.name==degreesDetailsController.selectedDegree.value)].schemes.map((e) => e.year.toString()).toList()
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
                                              degreesDetailsController.selectedScheme.value=newValue as int;
                                              int degreeIndex=degreesDetailsController.degreesDetail.degrees.indexWhere((element) => element.name==degreesDetailsController.selectedDegree.value);
                                              int schemeIndex=degreesDetailsController.degreesDetail.degrees[degreeIndex].schemes.indexWhere((element) => element.year==degreesDetailsController.selectedScheme.value);
                                              degreesDetailsController.selectedSchemeId.value=degreesDetailsController.degreesDetail.degrees[degreeIndex].schemes[schemeIndex].id;
                                            }))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Sem"),
                                        Container(
                                          width: 80,
                                          height: 50,
                                          child: TextFormField(
                                            controller: degreesDetailsController.semController,
                                            decoration: InputDecoration(
                                              labelText: 'Semester',
                                            ),
                                            keyboardType: TextInputType.none,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter semester';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Type"),
                                        Obx(() => DropdownButton(
                                            value: degreesDetailsController.examType.value,
                                            items: ['Regular','Supplementary']
                                                .map((scheme) => DropdownMenuItem(
                                                value: scheme,
                                                child: Text(scheme)))
                                                .toList(),
                                            onChanged: (newValue) {
                                              degreesDetailsController.examType.value=newValue!;
                                            }))
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Deadline"),
                                        Row(
                                          children: [
                                            Obx(() => Text(degreesDetailsController.deadlineDate.value),),
                                            IconButton(onPressed: (){
                                              showDatePicker(context: context,
                                                currentDate: DateTime.now(),
                                                firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
                                                lastDate: DateTime(DateTime.now().year+1,DateTime.now().month,DateTime.now().day),).then((value) {
                                                  if(value != null){
                                                    degreesDetailsController.deadlineDate.value="${value.year}-${value.month}-${value.day}";
                                                  }
                                              });
                                              }, icon: Icon(Icons.calendar_month_outlined)),
                                          ],
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: ()async{
                                        var body = json.encode({
                                          //TODO:Change it to dynamic
                                          "sem":int.parse(degreesDetailsController.semController.text),
                                          "is_supplementary":degreesDetailsController.examType.value=='Supplementary'?true:false,
                                          "paper_submission_deadline": degreesDetailsController.deadlineDate.value,
                                          "is_exam_completed": false,
                                          "description": "Loreum Ipsum",
                                          "degree": degreesDetailsController.selectedDegree.value,
                                          "scheme": degreesDetailsController.selectedSchemeId.value
                                        });
                                        print(body);
                                        await Get.find<MainController>().api.postNewExam(body);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding:EdgeInsets.symmetric(vertical: 6,horizontal: 40),
                                          child: Text('CREATE'),
                                        ),
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
    return Obx(() => GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: examController.exams.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>ExaminationTile(
        eid: examController.exams[index].eid,
        title: examController.exams[index].sem.toString(),
        examType: examController.exams[index].isSupplementary
            ? "Supplementary"
            : "Regular",
        date: DateFormat('yyyy-MM-dd').format(
            examController.exams[index].paperSubmissionDeadline),
        degree: examController.exams[index].degree,
      ),
    ));
  }
}
