import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paperswift/services/api_service.dart';

import '../routes/app_routes.dart';

class MainController extends GetxController{
  Logger log = Logger();
  late ApiService api;
  late FlutterSecureStorage storage;

  @override
  void onInit() async {
    storage = const FlutterSecureStorage();
    await checkToken();
    super.onInit();
  }

  Future checkToken() async {
    String? token = await storage.read(key: 'token');
    //TODO: Add validity check from API
    if (token != null) {
      api = ApiService(token: token);
      Get.toNamed(AppRoutes.home);
    } else {
      api = ApiService();
      Get.toNamed(AppRoutes.login);
    }
  }
}