import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/auth_controller.dart';
import 'package:paperswift/utils/constants.dart';

class SplashScreen extends StatelessWidget {
  AuthController authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Center(child: CircularProgressIndicator(color: Colors.white,),),
    );
  }
}
