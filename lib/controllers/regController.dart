import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_nest/utils/apiEndpoint.dart';
import 'package:http/http.dart' as http;

class regController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  int uId = 0;
// final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<void> registerUser() async {
    try{
      uId ++;
      var headers = { 'Content-Type' : 'application/json' };
      var url = Uri.parse(
        apiEndpoint.baseUrl + apiEndpoint.authEndPoints.reg
      );
      Map body ={
        "id": uId,
        "username": userName.text,
        "firstName": firstName.text,
        "lastName": lastName.text,
        "email": email.text,
        "password": password.text,
        "phone": phone.text,
        "userStatus": 1
      };

      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);
      if(response.statusCode == 200){
          print("Registered Successfully");
          userName.clear();
          firstName.clear();
          lastName.clear();
          email.clear();
          password.clear();
          phone.clear();
        }

      } catch (e){
      print("Error while registering, $e");
    }
  }
}