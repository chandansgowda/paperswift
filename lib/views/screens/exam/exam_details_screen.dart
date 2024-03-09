import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:paperswift/views/screens/dashboard/components/header.dart';
import 'package:paperswift/views/screens/dashboard/components/recent_files.dart';
import 'package:paperswift/views/screens/dashboard/components/storage_details.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import '../dashboard/components/my_files.dart';

class ExamDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Text("Exam details screen"),
              Header(label: "Exam - tile",),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        MyFiles(),
                        SizedBox(height: defaultPadding),
                        RecentFiles(),
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
                      child: StorageDetails(),
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
