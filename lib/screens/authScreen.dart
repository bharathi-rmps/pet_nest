import 'package:flutter/material.dart';
import 'package:pet_nest/components/button.dart';
import 'package:pet_nest/components/textField.dart';

class authScreen extends StatelessWidget{
  authScreen({super.key});

  //text controllers
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  //signin method
  void userSignin(String username, String password){
    print("signin button pressed $username, $password");
  }

  //forgot password
  void forgotPassword(){
    print("forgot password button pressed");
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
            children: [

              //top icon
              const SizedBox(height: 30),
                const Icon(
                  Icons.lock,
                size: 100,
              ),

              //login to continue text
              const SizedBox(height: 30),
              Text(
                "Hi, please login to continue!",
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

            //password textfield
              const SizedBox(height: 30),
              textField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

            //forgot password button
              const SizedBox(height: 15),
              const Padding(
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

            //login button
            const SizedBox(height: 30),
            button(
              onTap: ()=> userSignin(this.userNameController.text, this.passwordController.text),
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
              const SizedBox(height: 30),
              Row(
                children: [
                  Image.asset("lib/assets/google.png", height: 68,),
                ],
              ),
              
            //new user, register here
            const SizedBox(height: 30),

          ],),
        ),
      )
    );
  }
}