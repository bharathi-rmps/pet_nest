import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/profileFields.dart';
import 'package:pet_nest/components/promptBox.dart';
import 'package:pet_nest/controllers/profileController.dart';
import 'package:pet_nest/controllers/sessionController.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';

import 'subMainScreens/editProfileScreen.dart';

class profileScreen extends StatelessWidget {
  profileScreen({super.key});
  final sessionController _sessionController = Get.put(sessionController());

  profileController _profileController = Get.put(profileController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
        body: SafeArea(child:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SafeArea(
                child: Obx(() {
                  if(_sessionController.firstname.value == ''.obs){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //profile pic
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: AssetImage("lib/assets/profile.png"),
                      ),

                      //user name
                      const SizedBox(height: 30,),
                      profileFields(
                          title: "User Name",
                          subTitle: _sessionController.username.value,
                          isObscured: false ),

                      //full name
                      const SizedBox(height: 10,),
                      profileFields(
                          title: "Full Name",
                          subTitle: _sessionController.firstname.value.toString() + " " + _sessionController.lastname.value.toString(),
                          isObscured: false ),

                      //email
                      const SizedBox(height: 10,),
                      profileFields(
                          title: "Email ID",
                          subTitle: _sessionController.email.value,
                          isObscured: false ),

                      //password
                      const SizedBox(height: 10,),
                      profileFields(
                          title: "Password",
                          subTitle: _sessionController.password.value,
                          isObscured: true ),

                      //phone
                      const SizedBox(height: 10,),
                      profileFields(
                          title: "Contact Number",
                          subTitle: _sessionController.phone.value,
                          isObscured: false ),

                      //profile buttons
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //edit profile button
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child:
                            elevatedButtons(
                                onPressed: () {
                                  Get.to(() => editProfileScreen());
                                },
                                data: "Edit Profile",
                                color: Colors.deepOrangeAccent,
                                size: 14
                            ),
                          ),

                          //delete profile button
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child:
                            elevatedButtons(
                                onPressed: () {
                                  // show confirmation dialog
                                  promptBox.show(
                                      context: context,
                                      title: "Delete Profile",
                                      content: "Are you sure? you want to delete your profile",
                                      onConfirm: (){
                                        _profileController.deleteUser();
                                      });
                                },
                                data: "Delete Profile",
                                color: Colors.deepOrangeAccent,
                                size: 14
                            ),
                          ),

                          //logout button
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child:
                            elevatedButtons(
                                onPressed: () {
                                  // show confirmation dialog
                                  promptBox.show(
                                      context: context,
                                      title: "Logout Profile",
                                      content: "Are you sure? you want to logout your profile",
                                      onConfirm: (){
                                        _sessionController.logout();
                                      });
                                },
                                data: "Logout",
                                color: Colors.deepOrangeAccent,
                                size: 14
                            ),
                          ),

                        ],
                      ),
                    ],
                  );
                }),

              ),
            ),
          ),
        ),
    );
  }
}
