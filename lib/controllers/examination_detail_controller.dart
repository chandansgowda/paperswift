import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:paperswift/models/examination_detail.dart';
import 'package:paperswift/services/api_service.dart';

class ExaminationDetailController extends GetxController{
  late ExaminationDetail examinationDetail;
  late final String? token;
  late ApiService api;
  late FlutterSecureStorage storage;

  RxInt currentDepartmentIndex=0.obs;

  @override
  void onInit() async {
    storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    api=ApiService(token: token);
    super.onInit();
  }


  Future<void> fetchData(int examId) async {
    try {
      dynamic response =await api.getExaminationDetails(examId);
      examinationDetail=ExaminationDetail.fromJson(response);
      print(examinationDetail.departments[0].name);

    } catch (e) {
      throw Exception(e);
    }
  }
}