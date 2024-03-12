import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:paperswift/models/degree_details.dart';
import 'package:paperswift/services/api_service.dart';

class DegreesDetailsController extends GetxController{
  late DegreesDetail degreesDetail;
  late final String? token;
  late ApiService api;
  late FlutterSecureStorage storage;

  late RxString selectedDegree="".obs;
  late RxInt selectedScheme=0.obs;
  late RxInt selectedSchemeId=0.obs;
  TextEditingController semController=TextEditingController();
  RxString deadlineDate="${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}".obs;
  RxString examType='Regular'.obs;


  @override
  void onInit() async {
    storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    api=ApiService(token: token);
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    try {
      dynamic response =await api.getDegreesDetails();
      degreesDetail=DegreesDetail.fromJson(response);
      selectedDegree.value=degreesDetail.degrees[0].name;
      selectedScheme.value=degreesDetail.degrees[0].schemes[0].year;
      selectedSchemeId.value=degreesDetail.degrees[0].schemes[0].id;
      print(degreesDetail.degrees[0].name);
    } catch (e) {
      throw Exception(e);
    }
  }
}