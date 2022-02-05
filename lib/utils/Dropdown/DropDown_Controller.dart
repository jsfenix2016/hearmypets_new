import 'package:get/get.dart';

// ignore: camel_case_types
class Dropdown_controller extends GetxController {
  var indexList = 0.obs;
  var value = 0.obs;
  var isVisible = true.obs;
  var mensaje = ''.obs;
  var list = [].obs;

  Map<int, String> dicItems = Map<int, String>().obs;
}
