import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_nest/controllers/sessionController.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';
import 'package:pet_nest/screens/landingScreen.dart';
import 'package:pet_nest/utils/apiEndpoint.dart';

class profileController extends GetxController {

  //controller instance for session management
  final sessionController _sessionController = Get.put(sessionController());

  Future<void> updateUser() async {
    try{
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.userEndpoints.updateUserDetails + _sessionController.username.value);
      print("URL EDIT"+ url.toString());
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      Map body = {
        "id": _sessionController.id.value,
        "username": _sessionController.username.value,
        "firstName": _sessionController.firstname.value,
        "lastName": _sessionController.lastname.value,
        "email": _sessionController.email.value,
        "password": _sessionController.password.value,
        "phone": _sessionController.phone.value,
        "userStatus": _sessionController.userStatus.value,
      };

      print("BODY, "+ body.toString());
      http.Response response = await http.put(url, body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        _sessionController.saveSessionToStorage();
        Get.off(() => landingScreen());
        //print('API Response: ${response.body}');
        Get.snackbar(
          "Success",
          "Updated Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
      } else {
        print('Failed to update, response code: ${response.statusCode}');
        print('Response body: ${response.body}');
        Get.snackbar(
          "Error",
          "Failed to update user details.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
      }
    } catch (e){
      print("Error occured while editing, $e");
      Get.snackbar(
        "Error",
        "Error while trying to update user details.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
    }
  }

  Future<void> deleteUser() async {
    try{
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.userEndpoints.deleteUserDetails + _sessionController.username.value);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.delete(url, headers: headers);

      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
        Get.snackbar(
          "Success",
          "Deleted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
        _sessionController.logout();
        Get.off(() => loginUserScreen());
      } else {
        print('Failed to delete, response code: ${response.statusCode}');
        print('Response body: ${response.body}');
        Get.snackbar(
          "Error",
          "Failed to update user details.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
      }
    } catch (e){
      print("Error occured while deleting, $e");
      Get.snackbar(
        "Error",
        "Error while trying to update user details.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
    }
  }
}