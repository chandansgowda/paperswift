import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:paperswift/routes/app_routes.dart';
import 'package:paperswift/utils/constants.dart';

class AuthController extends GetxController {
  late FlutterSecureStorage storage;
  Logger log = Logger();
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    storage = const FlutterSecureStorage();
    super.onInit();
  }

  Future<void> login(String username,String email, String password,String otp) async {
    try {
      var url = Uri.parse('${baseUrl}login/');
      var headers = {'accept': 'application/json', 'Content-Type': 'application/json'};
      var body = json.encode({
        //TODO:Change it to dynamic
        'username':"admin",
        'otp':"1222",
        'email': "admin@admin.com",
        'password':'123',
      });

      isLoading.value = true;
      var response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        String token = jsonResponse['key'];

        // Store token in secure-storage
        await storage.write(key: "token", value: token);
        log.i("Login successful. Stored Token: $token");
        Get.toNamed(AppRoutes.home);
      } else {
        // Handle error responses here
        log.w('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      log.e('Error occurred while logging in: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      String token = storage.read(key: 'token').toString();

      var url = Uri.parse('${baseUrl}logout/');
      var headers = {
        'Authorization': 'Token $token',
        'accept': 'application/json',
      };

      // Clear token value
      storage.delete(key: 'token');
      var response = await http.post(url, headers: headers);

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        log.i(jsonResponse['detail']);
      } else {
        // Handle error responses here
        log.w('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      log.e('Error occurred: $error');
    } finally {
      isLoading.value = false;
    }
  }
}
