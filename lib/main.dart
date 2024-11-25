import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_nest/screens/landingScreen.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';
import 'package:pet_nest/controllers/sessionController.dart';

void main() async {
  await GetStorage.init(); // Initialize storage
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final sessionController _sessionController = Get.put(sessionController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Obx(() => _sessionController.isLoggedIn.value
          ? landingScreen(selectedIndex: 0,)
          : loginUserScreen()
      ),
    );
  }
}
