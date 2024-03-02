import 'package:get/get_navigation/src/routes/get_route.dart';

import '../views/screens/home_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      // binding: Binding(),
    ),
  ];
}
