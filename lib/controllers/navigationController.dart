import 'package:get/get.dart';

class navigationController extends GetxController {
  // index for selected nav item
  RxInt  selectedIndex = 0.obs;

  // method to update selected index
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
