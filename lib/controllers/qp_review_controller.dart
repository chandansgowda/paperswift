import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:paperswift/models/question_paper_detail.dart';
import 'package:paperswift/services/api_service.dart';

class QuestionPaperReviewController extends GetxController{
  late QuestionPaperDetail questionPaperDetail;
  late final String? token;
  late ApiService api;
  late FlutterSecureStorage storage;

  RxInt currentDepartmentIndex=0.obs;
  //TODO:Change the initial value
  RxInt currentCourseIndex=500.obs;
  late int examinationId;

  @override
  void onInit() async {
    storage = const FlutterSecureStorage();
    String? token = await storage.read(key: 'token');
    api=ApiService(token: token);
    super.onInit();
  }


  Future<void> fetchData(int examId) async {
    try {
      dynamic response =await api.getQuestionPaperDetails(examId);
      if(response.toString()!='{}') {
        questionPaperDetail = QuestionPaperDetail.fromJson(response);
        print(questionPaperDetail.departments[0].name);
      }
      else{
        questionPaperDetail=QuestionPaperDetail(departments: [], count: 0);
      }
      update();
    } catch (e) {
      throw Exception(e);
    }
  }
}