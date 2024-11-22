import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/controllers/loginController.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';
import 'package:pet_nest/controllers/sessionController.dart';

class landingScreen extends StatelessWidget{
  landingScreen({super.key});

  final sessionController _sessionController = Get.put(sessionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
          body: SafeArea(
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    _sessionController.logout();
                    Get.off(() => loginUserScreen());
                  },
                )
          ),
      ),
    );
  }
}