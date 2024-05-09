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
  //TODO:Change the initial value
  RxInt currentCourseIndex=500.obs;
  RxString currentCourseCode="".obs;
  late int examinationId;
  RxBool isLoading=false.obs;


  @override
  void onInit() async {
    storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    api=ApiService(token: token);
    super.onInit();
  }


  Future<void> fetchData(int examId) async {
    try {
      isLoading.value=true;
      dynamic response =await api.getExaminationDetails(examId);
      examinationDetail=ExaminationDetail.fromJson(response);
    } catch (e) {
      // print(e);
      throw Exception(e);
    }
    finally{
      isLoading.value=false;
    }
  }
}