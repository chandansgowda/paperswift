import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:paperswift/controllers/main_controller.dart';

class MainBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(MainController(), permanent: true);
  }
}