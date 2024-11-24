import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/controllers/sessionController.dart';
import 'package:pet_nest/screens/landingScreen.dart';
import 'package:pet_nest/utils/apiEndpoint.dart';
import 'package:http/http.dart' as http;

class regController extends GetxController {
  // Form submission status
  var isLoading = false.obs;
  var isOtpSent = false.obs;

  //controller instance for session management
  final sessionController _sessionController = Get.put(sessionController());

  // TextEditingControllers
  TextEditingController userNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  // Validate input
  String? validateInput(String firstName, String lastName, String email, String username, String password) {
    print("firstname, $firstName");
    if (username.isEmpty) return "Username cannot be empty";
    if (firstName.isEmpty) return "First Name cannot be empty";
    if (lastName.isEmpty) return "Last Name cannot be empty";
    if (email.isEmpty) return "Email cannot be empty";
    String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(emailPattern).hasMatch(email)) return "Please enter a valid email address";
    if (password.isEmpty) return "Password cannot be empty";
    String passwordPattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    if (!RegExp(passwordPattern).hasMatch(password)) return "Password must have atleast 8 Characters, include uppercase, lowercase, a number and symbol";
    return null;
  }

  // Register user
  Future<void> registerUser() async {
    isLoading.value = true;
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      var url = Uri.parse(
        apiEndpoint.baseUrl + apiEndpoint.authEndPoints.reg,
      );
      Map body = {
        "username": userNameController.text.trim(),
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
        "phone": phoneController.text.trim(),
        "userStatus": 1,
      };
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        Get.snackbar(
          "Success",
          "Registered Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
        _sessionController.createSession(userNameController.text.trim());
        Get.off(() => landingScreen());
        clearFields();
      } else {
        Get.snackbar(
          "Error",
          "Registration failed: ${response.reasonPhrase}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Exception",
        "Error while registering: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Clear all fields after successful registration
  void clearFields() {
    userNameController.clear();
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
    otpController.clear();
  }

  // Reset OTP state
  void resetOtpState() {
    isOtpSent.value = false; // Reset OTP state when needed
  }

  // Send OTP (simulate for now)
  void sendOtp() {
    if(phoneController == ""){
      Get.snackbar(
        "Validation Error",
        "Phone number cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    isOtpSent.value = true; // Set OTP sent state
    Get.snackbar(
      "OTP Sent",
      "Please use 1234 for Demo Purpose",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // Validate OTP (dummy check for demonstration)
  void validateOtp(BuildContext context) {

    if (phoneController.text.trim().isEmpty || phoneController.text.trim().length <= 3){
      Get.snackbar(
        "Error",
        "Phone number cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    if(otpController.text.trim() == ""){
      Get.snackbar(
        "Error",
        "OTP cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }
    if (otpController.text.trim() == "1234") {
      registerUser();
      Get.snackbar(
        "Success",
        "OTP Verified",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Invalid OTP",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
    otpController.clear();
    phoneController.clear();
  }
}
