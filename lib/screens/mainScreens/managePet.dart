import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/profileFields.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';
import 'package:pet_nest/screens/mainScreens/subMainScreens/addPetScreen.dart';
import 'package:pet_nest/screens/mainScreens/subMainScreens/deletePetScreen.dart';
import 'package:pet_nest/screens/mainScreens/subMainScreens/editPetScreen.dart';
import 'package:pet_nest/screens/mainScreens/subMainScreens/historyScreen.dart';

class managePet extends StatelessWidget {

  petDetailsController _petDetailsController = Get.put(petDetailsController());

  @override
  Widget build(BuildContext context) {
    _petDetailsController.getPetDetails();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [

                // manage pic
                SizedBox(height: 30,),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("lib/assets/manage.png") ,
                ),

                // available Pet Count
                const SizedBox(height: 30,),
                Obx(() => profileFields(
                  title: "Available Pet Count",
                  subTitle: _petDetailsController.availablePetList.length.toString(),
                  isObscured: false,
                )),

                // adopted Pet Count
                const SizedBox(height: 10,),
                Obx(() => profileFields(
                  title: "Adopted Pet Count",
                  subTitle: _petDetailsController.soldPetList.length.toString(),
                  isObscured: false,
                )),


                // manage buttons
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    //add pet button
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: elevatedButtons(
                          onPressed: () {
                            Get.to(()=> addPetScreen());
                          },
                          data: "   Add Pet   ",
                          color: Colors.deepOrangeAccent,
                          size: 16
                      ),
                    ),

                    // edit pet button
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: elevatedButtons(
                          onPressed: () {
                            Get.to(()=> editPetScreen());
                          },
                          data: "   Edit Pet   ",
                          color: Colors.deepOrangeAccent,
                          size: 16
                      ),
                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // history button
                    // delete pet button
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: elevatedButtons(
                          onPressed: () {
                            Get.to(() => petHistoryScreen());
                          },
                          data: "   History    ",
                          color: Colors.deepOrangeAccent,
                          size: 16
                      ),
                    ),

                    // delete pet button
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: elevatedButtons(
                          onPressed: () {
                            Get.to(()=> deletePetScreen());
                          },
                          data: " Delete Pet ",
                          color: Colors.deepOrangeAccent,
                          size: 16),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}