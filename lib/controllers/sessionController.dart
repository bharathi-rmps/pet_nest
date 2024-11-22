import 'package:get/get.dart';

class sessionController extends GetxController {
  //Reactive properties
  var isLoggedIn = false.obs;

  //check session
  void checkSession(){
    print("Session checked, $isLoggedIn");
  }

  //logout user
  void logout(){
    print("Logout button pressed");
    this.isLoggedIn.value = false;
  }

}