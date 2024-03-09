import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/utils/constants.dart';

import '../../../controllers/main_controller.dart';

class SplashScreen extends StatelessWidget {
  final MainController mainController=Get.put(MainController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: bgColor,
      body: Center(child: CircularProgressIndicator(color: Colors.white,),),
    );
  }
}
