import 'package:get/get.dart';

class navigationController extends GetxController {
  // Observable index for selected nav item
  var selectedIndex = 0.obs;

  // Method to update selected index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
