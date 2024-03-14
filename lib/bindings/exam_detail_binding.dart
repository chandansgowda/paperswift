import 'package:get/get.dart';
import 'package:paperswift/controllers/main_controller.dart';


class ExamDetailBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(MainController(),permanent: true);
  }
}