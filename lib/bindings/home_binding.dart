import 'package:get/get.dart';
import 'package:paperswift/controllers/degree_detail_controller.dart';
import 'package:paperswift/controllers/exam_controller.dart';
import 'package:paperswift/controllers/examination_detail_controller.dart';
import 'package:paperswift/controllers/main_controller.dart';
import 'package:paperswift/controllers/qp_review_controller.dart';
import 'package:paperswift/controllers/screen_controller.dart';


class HomeBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(MainController(),permanent: true);
    Get.put(ScreenController());
    Get.put(ExamController());
    Get.put(DegreesDetailsController());
    Get.put(ExaminationDetailController());
    Get.put(QuestionPaperReviewController());
  }
}