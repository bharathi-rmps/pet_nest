import 'dart:convert';
import 'package:pet_nest/screens/auth/loginUser.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pet_nest/utils/apiEndpoint.dart';

class loginController{
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> loginUser() async {
    var headers = {'Content-Type' : 'application/json'};
    try{
      var url = Uri.parse(
        apiEndpoint.baseUrl + apiEndpoint.authEndPoints.login
      );
      Map body = {
        'username' : userName.text,
        'password' : password.text
      };
      http.Response response = await http.post(url, body: jsonEncode(body), headers: headers);

      if(response.statusCode == 200){
        print("Login success");
        userName.clear();
        password.clear();
      }
    } catch(e){
      print("error, $e");
    }
  }
}