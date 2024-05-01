import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:paperswift/bindings/exam_detail_binding.dart';
import 'package:paperswift/bindings/home_binding.dart';
import 'package:paperswift/controllers/main_controller.dart';
import 'package:paperswift/views/screens/document_upload/document_upload_screen.dart';
import 'package:paperswift/views/screens/exam/exam_details_screen.dart';
import 'package:paperswift/views/screens/home/login_screen.dart';
import 'package:paperswift/views/screens/home/splash_screen.dart';
import 'package:paperswift/views/screens/review/qp_review_screen.dart';

import '../views/screens/home/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      //middlewares: [AuthMiddleware()],
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
        name: AppRoutes.docsUploadScreen, page: () => DocumentUploadScreen()),
    GetPage(
        name: AppRoutes.qpReviewScreen,
        page: () => QuestionPaperReviewScreen()),
    GetPage(
      name: AppRoutes.examDetails,
      page: () => ExamDetailsScreen(),
      //middlewares: [AuthMiddleware()],
      binding: ExamDetailBinding(),
    ),
  ];
}
//
// class AuthMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     print("This is the token :${Get.find<MainController>().api.token}");
//     if(Get.find<MainController>().api.token == null) {
//       return  const RouteSettings(name: AppRoutes.login);
//     } else {
//       return null;
//     }
//   }
// }
