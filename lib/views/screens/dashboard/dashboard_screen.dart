
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/exam_controller.dart';
import 'package:paperswift/views/screens/dashboard/components/previous_exams.dart';

import '../../../utils/constants.dart';
import '../../../utils/responsive.dart';
import 'components/header.dart';

import 'components/in_progress_exams_container.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  ExamController examController=Get.find<ExamController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(label: "Dashboard",),
            SizedBox(height: defaultPadding),
            Obx(() => examController.isLoading.value?SizedBox(
                height: Get.height*0.8,
                child: Center(child: CircularProgressIndicator(),)):Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      InProgressExamsContainer(),
                      SizedBox(height: defaultPadding),
                      PreviousExams(),
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
            ))

          ],
        ),
      ),
    );
  }
}
