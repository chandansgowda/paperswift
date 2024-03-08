import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paperswift/routes/app_routes.dart';
import 'package:paperswift/services/api_service.dart';

class AuthController extends GetxController {
  late FlutterSecureStorage storage;
  Logger log = Logger();
  late ApiService api;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    storage = const FlutterSecureStorage();
    await checkToken();
    super.onInit();
  }

  Future checkToken() async {
    String? token = await storage.read(key: 'token');
    if (token != null) {
      api = ApiService(token: token);
      Get.toNamed(AppRoutes.home);
    } else {
      api = ApiService();
      Get.toNamed(AppRoutes.login);
    }
  }

  Future<void> login(String username, String email, String password, String otp) async {
    try {
      isLoading.value = true;

      var body = json.encode({
        //TODO:Change it to dynamic
        'username': "admin",
        'otp': "1222",
        'email': "admin@admin.com",
        'password': '123',
      });

      String? token = await api.login(body);

      if (token != null) {
        api = ApiService(token: token);
        await storage.write(key: "token", value: token);
        log.i("Login successful. Stored Token: $token");
      }

      Get.toNamed(AppRoutes.home);

    } catch (error) {
      log.e('Error occurred while logging in: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      String? token = await storage.read(key: 'token');
      log.i("Token: $token");

      storage.delete(key: 'token');
      var response = await api.logout();
      //TODO: Handle error in api call
      Get.offAllNamed(AppRoutes.login);
    } catch (error) {
      log.e('Error occurred: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
