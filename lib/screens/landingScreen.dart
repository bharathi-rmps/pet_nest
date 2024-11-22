import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';
import 'package:pet_nest/controllers/sessionController.dart';

class landingScreen extends StatelessWidget {
  landingScreen({super.key});

  final sessionController _sessionController = Get.put(sessionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () {
                  _sessionController.logout();
                  Get.off(() => loginUserScreen());
                },
              ),
              const SizedBox(height: 30),

              // Reactive Widgets
              Obx(() => Text("Logged In: ${_sessionController.isLoggedIn.value}")),
              Obx(() => Text("ID: ${_sessionController.id.value}")),
              Obx(() => Text("Username: ${_sessionController.username.value}")),
              Obx(() => Text("First Name: ${_sessionController.firstname.value}")),
              Obx(() => Text("Last Name: ${_sessionController.lastname.value}")),
              Obx(() => Text("Email: ${_sessionController.email.value}")),
              Obx(() => Text("Password: ${_sessionController.password.value}")),
            ],
          ),
        ),
      ),
    );
  }
}
