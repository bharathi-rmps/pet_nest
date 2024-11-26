import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_nest/controllers/sessionController.dart';
import 'package:pet_nest/screens/landingScreen.dart';
import 'package:pet_nest/utils/apiEndpoint.dart';

class loginController extends GetxController {
  // TextEditingControllers
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //controller instance for session management
  final sessionController _sessionController = Get.put(sessionController());

  // Reactive properties
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Login function
  Future<void> loginUser() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      var url = Uri.parse(
          "${apiEndpoint.baseUrl}${apiEndpoint.authEndPoints.login}?username=${userNameController.text}&password=${passwordController.text}");

      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        _sessionController.createSession(userNameController.text.trim());

        Get.snackbar(
          "Success",
          "Login successful!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear input fields
        clearFields();

        // Navigate to the landing screen
        Get.off(() => landingScreen(selectedIndex: 0,));
      } else {
        _sessionController.isLoggedIn.value = false;
        errorMessage.value = "Login failed: ${response.reasonPhrase}";
        Get.snackbar(
          "Error",
          errorMessage.value,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      Get.snackbar(
        "Error",
        errorMessage.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear all inputs
  void clearFields() {
    userNameController.clear();
    passwordController.clear();
  }

}
