import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/profileFields.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';
import 'package:pet_nest/screens/mainScreens/subMainScreens/addPetScreen.dart';
import 'package:pet_nest/screens/mainScreens/subMainScreens/deletePetScreen.dart';
import 'package:pet_nest/screens/mainScreens/subMainScreens/editPetScreen.dart';

class managePet extends StatelessWidget {

  petDetailsController _petDetailsController = Get.put(petDetailsController());

  @override
  Widget build(BuildContext context) {
    _petDetailsController.availablePetList();
    _petDetailsController.soldPetList();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: Column(
              children: [

                //manage pic
                SizedBox(height: 30,),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("lib/assets/manage.png") ,
                ),

                //Available Pet Count
                const SizedBox(height: 30,),
                profileFields(
                    title: "Available Pet Count",
                    subTitle: _petDetailsController.availablePetList.length.toString(),
                    isObscured: false ),

                //Adopted Pet Count
                const SizedBox(height: 10,),
                profileFields(
                    title: "Adopted Pet Count",
                    subTitle: _petDetailsController.soldPetList.length.toString(),
                    isObscured: false ),


                //manage buttons
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //add pet button
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(()=> addPetScreen());
                        },
                        child: Text("Add Pet"),
                      ),
                    ),

                    //edit pet button
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(onPressed: () {
                        Get.off(() => editPetScreen()
                        );
                      }, child: Text("Edit Pet")),
                    ),

                    //delete pet button
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(() => deletePetScreen());
                        },
                        child: Text("Delete Pet"),
                      ),
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