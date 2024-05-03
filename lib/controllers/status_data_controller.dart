import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:paperswift/services/api_service.dart';

class StatusDataController extends GetxController{
  RxBool isLoading=false.obs;
  RxMap statusData={}.obs;
  late final String? token;
  late ApiService api;
  late FlutterSecureStorage storage;

  @override
  void onInit() async {
    storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    api=ApiService(token: token);
    await fetchData();
    super.onInit();
  }
  Future<void> fetchData() async{
    try {
      isLoading.value=true;
      dynamic response=await api.fetchReport();
      print(response);
      statusData.value=response;
    } catch (e) {
      throw Exception(e);
    }
    finally{
      isLoading.value=false;
    }
  }
}