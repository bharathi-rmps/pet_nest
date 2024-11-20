import 'package:flutter/material.dart';
import 'package:pet_nest/components/signupButton.dart';
import 'package:pet_nest/components/squareTileImage.dart';
import 'package:pet_nest/components/textField.dart';

class signupUser extends StatelessWidget{
  signupUser({super.key});

  //text controllers

  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  //signin method
  void userSignup(String username, String firstName, String lastName, String email, String password, String phone){
    print("signin button pressed $username, $firstName, $lastName, $email, $password, $phone");
  }


  //signup method
  void signup(){
    print("signup button pressed");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //top icon
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                //login to continue text
                const SizedBox(height: 50),
                Text(
                  "Hi, please login or signup to continue!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                //username textfield
                const SizedBox(height: 30),
                textField(
                  controller: userNameController,
                  hintText: 'Username',
                  obscureText: false,
                ),

                //firstname textfield
                const SizedBox(height: 30),
                textField(
                  controller: firstNameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),

                //lastname textfield
                const SizedBox(height: 30),
                textField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  obscureText: false,
                ),

                //email textfield
                const SizedBox(height: 30),
                textField(
                  controller: emailController,
                  hintText: 'E-Mail ID',
                  obscureText: false,
                ),

                //password textfield
                const SizedBox(height: 30),
                textField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                //phone number textfield
                const SizedBox(height: 30),
                textField(
                  controller: phoneController,
                  hintText: 'Contact Number',
                  obscureText: false,
                ),

                //login button
                const SizedBox(height: 15),
                signupButton(
                  onTap: ()=> userSignup(
                      this.userNameController.text,
                      this.firstNameController.text,
                      this.lastNameController.text,
                      this.emailController.text,
                      this.passwordController.text,
                      this.phoneController.text
                  ),
                ),

                //other signin options
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

                //images
                // const SizedBox(height: 30),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     squareTileImage(imgPath: 'lib/assets/google.png'),
                //     squareTileImage(imgPath: 'lib/assets/apple.png'),
                //   ],
                // ),

                //new user, register here
                const SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have an Account? ",
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      const Text(
                        "Login Now!",
                        style: TextStyle(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ]
                ),
              ],),
          ),
        )
    );
  }
}