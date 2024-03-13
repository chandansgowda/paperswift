import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paperswift/bindings/main_binding.dart';
import 'package:paperswift/controllers/auth_controller.dart';
import 'package:paperswift/routes/app_pages.dart';
import 'package:paperswift/routes/app_routes.dart';
import 'package:paperswift/utils/constants.dart';
import 'package:paperswift/views/screens/home/login_screen.dart';
import 'views/screens/home/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PaperSwift',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      initialBinding: MainBinding(),
    );
  }
}