import 'package:get/get.dart';
import 'package:paperswift/controllers/main_controller.dart';
import 'package:paperswift/controllers/qp_review_controller.dart';


class QuestionPaperReviewBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(MainController(),permanent: true);
  }
}