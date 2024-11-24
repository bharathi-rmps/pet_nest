import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/promptBox.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';
import 'package:pet_nest/screens/landingScreen.dart';
import 'package:pet_nest/screens/mainScreens/managePet.dart';

import '../../../components/textField.dart';

class addPetScreen extends StatelessWidget{

  TextEditingController petCategoryName = TextEditingController();
  TextEditingController petName = TextEditingController();
  TextEditingController petImageUrl = TextEditingController();

  // input validation
  String? validateInput(String petCategoryName, String petname, String petImageUrl){
    if(petCategoryName.isEmpty) return "Pet Category Name cannot be Empty";
    if(petname.isEmpty) return "Pet Name cannot be Empty";
    if(petImageUrl.isEmpty) return "Pet Image URL cannot be Empty";
    return null;
  }

  petDetailsController _petDetailsController = Get.put(petDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Pet"),
        centerTitle: true,
      ),
      body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.all(4),
         child: Column(
          children: [

              //Pet Category Name
              const SizedBox(height: 25,),
              textField(
                controller: petCategoryName,
                hintText: "Please type your pet category",
                obscureText: false,
                labelText: "Pet Category"
            ),

            //Pet Name
            const SizedBox(height: 25,),
            textField(
                controller: petName,
                hintText: "Please type your pet name",
                obscureText: false,
                labelText: "Pet Name"
            ),

            //Pet Image Url
            const SizedBox(height: 25,),
            textField(
                controller: petImageUrl,
                hintText: "Please pase your pet image URL",
                obscureText: false,
                labelText: "Pet Image Url"
            ),

            //buttons
            const SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                //cancel button
                elevatedButtons(
                    onPressed: (){
                      Get.off(() => landingScreen());
                    },
                    data: "Cancel",
                    color: Colors.deepOrangeAccent,
                    size: 18
                ),

                //submit button
                elevatedButtons(
                    onPressed: (){
                      String? errorMessage = validateInput(petCategoryName.text, petName.text, petImageUrl.text);
                      if(errorMessage != null){
                        Get.snackbar(
                          "Validation Error",
                          errorMessage,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                        );
                      } else{
                        promptBox.show(
                          context: context,
                          title: "Add Pet Confirmation",
                          content: "Are you sure, add your Pet?",
                          onConfirm: () {
                            _petDetailsController.addPet(
                                petCategoryName.text,
                                petName.text,
                                petImageUrl.text
                            );
                          },
                        );
                      }
                    },
                    data: "Submit",
                    color: Colors.deepOrangeAccent,
                    size: 18
                ),

              ],
            ),


          ],
               ),
       ),),
    );
  }
}