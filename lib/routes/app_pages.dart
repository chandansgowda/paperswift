import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:paperswift/bindings/exam_detail_binding.dart';
import 'package:paperswift/bindings/home_binding.dart';
import 'package:paperswift/views/screens/exam/exam_details_screen.dart';
import 'package:paperswift/views/screens/home/login_screen.dart';
import 'package:paperswift/views/screens/home/splash_screen.dart';

import '../views/screens/home/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
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
      name: AppRoutes.examDetails,
      page: () => ExamDetailsScreen(),
      binding: ExamDetailBinding()
    ),
  ];
}
