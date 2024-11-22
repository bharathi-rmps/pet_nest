import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/signupButton.dart';
import 'package:pet_nest/components/textField.dart';
import 'package:pet_nest/controllers/regController.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../components/squareTileImage.dart';

class signupUserScreen extends StatelessWidget {
  signupUserScreen({super.key});

  final regController _regController = Get.put(regController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Obx(
            () => _regController.isLoading.value
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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

                  const SizedBox(height: 40),
                  Text(
                    "Hi, please login or signup to continue!",
                    style: TextStyle(color: Colors.grey[700], fontSize: 16),
                  ),

                  const SizedBox(height: 30),
                  textField(
                    labelText: "User Name",
                    controller: _regController.userNameController,
                    hintText: 'Please enter your username',
                    obscureText: false,
                  ),

                  const SizedBox(height: 30),
                  textField(
                    labelText: "First Name",
                    controller: _regController.firstNameController,
                    hintText: 'Please enter your first name',
                    obscureText: false,
                  ),

                  const SizedBox(height: 30),
                  textField(
                    labelText: "Last Name",
                    controller: _regController.lastNameController,
                    hintText: 'Please enter your last name',
                    obscureText: false,
                  ),

                  const SizedBox(height: 30),
                  textField(
                    labelText: "E-Mail ID",
                    controller: _regController.emailController,
                    hintText: 'Please enter your email id',
                    obscureText: false,
                  ),

                  const SizedBox(height: 30),
                  textField(
                    labelText: "Password",
                    controller: _regController.passwordController,
                    hintText: 'Please enter your password',
                    obscureText: true,
                  ),

                  const SizedBox(height: 30),
                  signupButton(
                    onTap: () {
                      String? errorMessage = _regController.validateInput(
                        _regController.firstNameController.text,
                        _regController.lastNameController.text,
                        _regController.emailController.text,
                        _regController.userNameController.text,
                        _regController.passwordController.text,
                      );
              
                      if (errorMessage != null) {
                        Get.snackbar(
                          "Validation Error",
                          errorMessage,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      } else {
                        _regController.sendOtp();
                        showOtpDialog(context);
                      }
                    },
                  ),

                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an Account? ",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      GestureDetector(
                        onTap: () {
                          _regController.clearFields();
                          Get.to(() => loginUserScreen(),
                          );
                        },
                        child: const Text(
                          "Login Now!",
                          style: TextStyle(color: Colors.blueAccent),
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

  void showOtpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return GetBuilder<regController>(
          builder: (controller) {
            return AlertDialog(
              title: const Text("Verify Phone Number"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  // Phone number input with country code
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      controller.phoneController.text = number.phoneNumber!;
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                    ignoreBlank: false,
                    keyboardType: TextInputType.number,
                    inputDecoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number with country code',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Send OTP button
                  if (!controller.isOtpSent.value)
                    ElevatedButton(
                      onPressed: () {
                        // Send OTP and update the state
                        controller.sendOtp();
                      },
                      child: const Text("Send OTP"),
                    ),
                  // Show OTP field only if OTP is sent
                  if (controller.isOtpSent.value) ...[
                    const SizedBox(height: 20),
                    TextField(
                      controller: controller.otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Enter OTP",
                        hintText: "Please use 1234 for Demo",
                      ),
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    // Validate OTP
                    controller.validateOtp(context);
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
