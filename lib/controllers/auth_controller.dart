import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paperswift/controllers/main_controller.dart';

import '../routes/app_routes.dart';
import '../services/api_service.dart';

class AuthController extends GetxController {
  late FlutterSecureStorage storage;
  late Logger log;
  late ApiService api;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    MainController mainController = Get.find<MainController>();
    storage = mainController.storage;
    api = mainController.api;
    log = mainController.log;
    super.onInit();
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
    print("Logout is pressed");
    try {
      isLoading.value = true;
      String? token = await storage.read(key: 'token');
      log.i("Token: $token");
      await storage.delete(key: 'token');
      print("object");
      token = await storage.read(key: 'token');
      print("Token $token");
      // api.logout().then((value){
      //   print(value);
      //   if(value){
      //     Get.offAllNamed(AppRoutes.login);
      //   }
      //
      // });
      //TODO: Handle error in api call

    } catch (error) {
      log.e('Error occurred: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
