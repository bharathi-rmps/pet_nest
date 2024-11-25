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

  final petDetailsController _petDetailsController = Get.find<petDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("Add Pet"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[300],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
       child: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(4),
           child: Column(
             children: [

               // Banner Image
               SizedBox(height: 1,),
               Container(
                 height: 200,
                 width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                   color: Colors.indigoAccent,
                   borderRadius: BorderRadius.circular(10),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.grey.withOpacity(1),
                       blurRadius: 5,
                       offset: const Offset(0, 3),
                     ),
                   ],
                 ),
                 clipBehavior: Clip.antiAlias,
                 child: Image.asset(
                   "lib/assets/add pet banner.png",
                   fit: BoxFit.cover,
                 ),
               ),

               //text
               SizedBox(height: 20,),
               const Text(
                 "Please fill the below contents",
                 style: TextStyle(
                     fontSize: 18,
                     fontWeight: FontWeight.bold
                 ),
               ),

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
                         Get.off(() => landingScreen(selectedIndex: 1,));
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
                             onConfirm: () async {
                               await _petDetailsController.addPet(
                                 petCategoryName.text,
                                 petName.text,
                                 petImageUrl.text,
                               );
                               Get.off(() => landingScreen(selectedIndex: 1));
                             }
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
    ),
    );
  }
}