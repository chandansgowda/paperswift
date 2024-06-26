import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/exam_controller.dart';
import 'package:paperswift/controllers/screen_controller.dart';
import 'package:paperswift/views/screens/review/qp_review_screen.dart';

import '../../../utils/responsive.dart';
import '../dashboard/dashboard_screen.dart';
import 'components/side_menu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenController screenController=Get.find<ScreenController>();
    ExamController examController=Get.find<ExamController>();
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Obx((){
                switch(screenController.screenIndex.value){
                  case 0:return DashboardScreen();
                  default:return Center(child: Obx((){
                    return Text(examController.exams.toString());
                  }),);
                }
            }),
            ),
          ],
        ),
      ),
    );
  }
}
