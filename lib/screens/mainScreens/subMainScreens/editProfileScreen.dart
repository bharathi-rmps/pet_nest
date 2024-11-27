import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/promptBox.dart';
import 'package:pet_nest/components/textField.dart';
import 'package:pet_nest/controllers/sessionController.dart';
import 'package:pet_nest/screens/landingScreen.dart';

import '../../../controllers/profileController.dart';

class editProfileScreen extends StatelessWidget {
  editProfileScreen({super.key});

  // Controllers for the text fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Get instance of sessionController
  final sessionController _sessionController = Get.put(sessionController());

  profileController _profileController = Get.put(profileController());

  // Validate input
  String? validateInput(String firstName, String lastName, String email, String username, String password) {
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

  @override
  Widget build(BuildContext context) {
    // Pre-fill the controllers with current session values
    usernameController.text = _sessionController.username.value;
    firstNameController.text = _sessionController.firstname.value;
    lastNameController.text = _sessionController.lastname.value;
    emailController.text = _sessionController.email.value;
    phoneController.text = _sessionController.phone.value;
    passwordController.text = _sessionController.password.value;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //user name
              const SizedBox(height: 25,),
              textField(
                  controller: usernameController,
                  hintText: "Please edit your username",
                  obscureText: false,
                  labelText: "User Name"
              ),

              //first name
              const SizedBox(height: 30,),
              textField(
                  controller: firstNameController,
                  hintText: "Please edit your first name",
                  obscureText: false,
                  labelText: "First Name"
              ),

              //first name
              const SizedBox(height: 30,),
              textField(
                  controller: lastNameController,
                  hintText: "Please edit your last name",
                  obscureText: false,
                  labelText: "Last Name"
              ),

              //email id
              const SizedBox(height: 30,),
              textField(
                  controller: emailController,
                  hintText: "Please edit your Email Id",
                  obscureText: false,
                  labelText: "Email Id"
              ),

              //phone
              const SizedBox(height: 30,),
              textField(
                  controller: phoneController,
                  hintText: "Please edit your Contact Number",
                  obscureText: false,
                  labelText: "Contact Number"
              ),

              //password
              const SizedBox(height: 30,),
              textField(
                  controller: passwordController,
                  hintText: "Please edit your Password",
                  obscureText: true,
                  labelText: "Password"
              ),

              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  //go back button
                  elevatedButtons(
                      onPressed: (){
                    Get.off(() => landingScreen(selectedIndex: 2,));
                    },
                      data: "Cancel",
                      color: Colors.deepOrangeAccent,
                      size: 18),

                  //save changes button
                  elevatedButtons(
                      onPressed: () {
                        promptBox.show(
                          context: context,
                          title: "Edit Details Confirmation",
                          content: "Are you sure you want to Save the Changes?",
                          onConfirm: () async{
                            String? errorMessage = validateInput(
                                firstNameController.text,
                                lastNameController.text,
                                emailController.text,
                                usernameController.text,
                                passwordController.text
                            );
                            if(errorMessage != null){
                              Get.snackbar(
                                "Validation Error",
                                errorMessage,
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                              );
                            } else{
                              // Save the changes
                              _sessionController.username.value = usernameController.text;
                              _sessionController.password.value = passwordController.text;
                              _sessionController.firstname.value = firstNameController.text;
                              _sessionController.lastname.value = lastNameController.text;
                              _sessionController.email.value = emailController.text;
                              _sessionController.phone.value = phoneController.text;

                              //api call to update
                              await _profileController.updateUser();
                            }
                          },
                        );
                      },
                      data: "Save Changes",
                      color: Colors.deepOrangeAccent,
                      size: 16
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
