import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/futureFeature.dart';
import 'package:pet_nest/components/signinButton.dart';
import 'package:pet_nest/components/squareTileImage.dart';
import 'package:pet_nest/components/textField.dart';
import 'package:pet_nest/controllers/loginController.dart';
import 'package:pet_nest/screens/auth/signupUser.dart';

import '../../controllers/sessionController.dart';

class loginUserScreen extends StatelessWidget {
  loginUserScreen({super.key});

  // Use GetX to retrieve the controller instance
  final loginController _loginController = Get.put(loginController());
  final sessionController _sessionController = Get.put(sessionController());

  // Input validation
  String? validateInput(String username, String password) {
    if (username.isEmpty) {
      return "Username cannot be empty";
    }
    if (password.isEmpty) {
      return "Password cannot be empty";
    }
    String pattern =
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    if (!RegExp(pattern).hasMatch(password)) {
      return "Password must have at least 8 characters, include uppercase, lowercase, a number, and a symbol.";
    }
    return null;
  }

  // Sign-in method
  void userSignin() async {
    String username = _loginController.userNameController.text.trim();
    String password = _loginController.passwordController.text.trim();
    String? errorMessage = validateInput(username, password);

    if (errorMessage != null) {
      Get.snackbar(
        "Validation Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } else {
      await _loginController.loginUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Obx(
                () => _loginController.isLoading.value
                ? const CircularProgressIndicator()
                : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Top icon
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            "lib/assets/pet.png",
                            height: 85,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Login to continue text
                  const SizedBox(height: 50),
                  Text(
                    "Hi, please login continue!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),

                  // Username textfield
                  const SizedBox(height: 30),
                  textField(
                    labelText: "User Name",
                    controller: _loginController.userNameController,
                    hintText: 'Please enter your username',
                    obscureText: false,
                  ),

                  // Password textfield
                  const SizedBox(height: 30),
                  textField(
                    labelText: "Password",
                    controller: _loginController.passwordController,
                    hintText: 'Please enter your  password',
                    obscureText: true,
                  ),

                  // Forgot password button
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      futureFeature();
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Login button
                  const SizedBox(height: 15),
                  signinButton(
                    onTap: userSignin,
                  ),

                  // Other signin options
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Or Continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),

                  // Social login images
                  const SizedBox(height: 30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      squareTileImage(imgPath: 'lib/assets/google.png', imgSize: 65,),
                      squareTileImage(imgPath: 'lib/assets/apple.png', imgSize: 65,),
                    ],
                  ),

                  // New user? Register here
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New User? ",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _loginController.clearFields();
                          Get.to(() => signupUserScreen());
                        },
                        child: const Text(
                          "Register Now!",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}