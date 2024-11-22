import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_nest/components/profileFields.dart';
import 'package:pet_nest/controllers/sessionController.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';


class profileScreen extends StatelessWidget {
  profileScreen({super.key});
  final sessionController _sessionController = Get.put(sessionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                //profile pic
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("lib/assets/profile.png"),
                ),

                //user name
                const SizedBox(height: 30,),
                profileFields(title: "User Name", subTitle: _sessionController.username.value, isObscured: false ),

                //full name
                const SizedBox(height: 10,),
                profileFields(title: "Full Name", subTitle: _sessionController.firstname.value.toString() + " " + _sessionController.lastname.value.toString(), isObscured: false ),

                //email
                const SizedBox(height: 10,),
                profileFields(title: "Email ID", subTitle: _sessionController.email.value, isObscured: false ),

                //password
                const SizedBox(height: 10,),
                profileFields(title: "Password", subTitle: _sessionController.password.value, isObscured: true ),

                //phone
                const SizedBox(height: 10,),
                profileFields(title: "Contact Number", subTitle: _sessionController.phone.value, isObscured: false ),

                //edit profile
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //edit profile button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: () {}, child: Text("Edit Profile")),
                        ),

                        //logout button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(onPressed: () {
                            _sessionController.logout();
                            Get.off(() => loginUserScreen());
                          }, child: Text("Logout")),
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
