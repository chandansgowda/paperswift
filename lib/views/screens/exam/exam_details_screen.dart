import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/routes/app_routes.dart';
import 'package:paperswift/views/screens/dashboard/components/recent_files.dart';
import 'package:paperswift/views/screens/dashboard/components/storage_details.dart';
import 'package:paperswift/views/screens/exam/components/TeachersListContainer.dart';
import 'package:paperswift/views/screens/exam/components/assignment_list_container.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';

class ExamDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                Get.close(1);
              }, icon: Icon(Icons.close),),
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
                                ElevatedButton.icon(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 1.5,
                                      vertical: defaultPadding /
                                          (Responsive.isMobile(context)
                                              ? 2
                                              : 1),
                                    ),
                                  ),
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                  label: Text("Add New"),
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
                                childAspectRatio:4,
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
  const DepartmentTileGridView({
    Key? key,
    this.crossAxisCount = 5,
    this.childAspectRatio = 0.5,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    List departments=['CSE','ECE','EEE','BCA','ISE','MSC'];
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: departments.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => DepartmentTile(title:departments[index]),
    );
  }
}

class DepartmentTile extends StatelessWidget {
  final String title;

  const DepartmentTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: (){
      //TODO:Change the table details
    },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(child: Text(title))
      ),
    );
  }
}