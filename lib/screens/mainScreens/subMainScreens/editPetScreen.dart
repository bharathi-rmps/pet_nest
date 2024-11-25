import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/promptBox.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';
import 'package:pet_nest/screens/landingScreen.dart';

import '../../../components/textField.dart';

class editPetScreen extends StatelessWidget {
  final TextEditingController petCategoryName = TextEditingController();
  final TextEditingController petName = TextEditingController();
  final TextEditingController petImageUrl = TextEditingController();

  final petDetailsController _petDetailsController = Get.find<petDetailsController>();
  final Rx<Pet?> selectedPet = Rx<Pet?>(null); // Track the selected pet

  // Input validation
  String? validateInput(String petCategoryName, String petName, String petImageUrl) {
    if (petCategoryName.isEmpty) return "Pet Category Name cannot be empty";
    if (petName.isEmpty) return "Pet Name cannot be empty";
    if (petImageUrl.isEmpty) return "Pet Image URL cannot be empty";
    return null;
  }

  void updateTextFields(Pet pet) {
    petCategoryName.text = pet.category;
    petName.text = pet.name;
    petImageUrl.text = pet.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("Edit Pet"),
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
                  height: 220,
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
                    "lib/assets/edit pet banner.png",
                    fit: BoxFit.cover,
                  ),
                ),

                //text
                SizedBox(height: 20,),
                const Text(
                  "Please Select the Pet and Edit",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),

                // Pet Dropdown
                const SizedBox(height: 25),
                Obx(() {
                  return DropdownButton<Pet>(
                    hint: Text("Select a Pet"),
                    value: selectedPet.value,
                    onChanged: (Pet? newPet) {
                      selectedPet.value = newPet;
                      if (newPet != null) {
                        updateTextFields(newPet); // Populate text fields
                      }
                    },
                    items: _petDetailsController.availablePetList
                        .map((pet) => DropdownMenuItem<Pet>(
                      value: pet,
                      child: Text(pet.name),
                    ))
                        .toList(),
                  );
                }),

                // Pet Category Name
                const SizedBox(height: 25),
                textField(
                  controller: petCategoryName,
                  hintText: "Please type your pet category",
                  obscureText: false,
                  labelText: "Pet Category",
                ),

                // Pet Name
                const SizedBox(height: 25),
                textField(
                  controller: petName,
                  hintText: "Please type your pet name",
                  obscureText: false,
                  labelText: "Pet Name",
                ),

                // Pet Image URL
                const SizedBox(height: 25),
                textField(
                  controller: petImageUrl,
                  hintText: "Please paste your pet image URL",
                  obscureText: false,
                  labelText: "Pet Image URL",
                ),

                // Buttons
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Cancel Button
                    elevatedButtons(
                      onPressed: () {
                        Get.off(() => landingScreen(selectedIndex: 1,));
                      },
                      data: "Cancel",
                      color: Colors.deepOrangeAccent,
                      size: 18,
                    ),

                    // Submit Button
                    elevatedButtons(
                      onPressed: () {
                        String? errorMessage =
                        validateInput(petCategoryName.text, petName.text, petImageUrl.text);
                        if (errorMessage != null) {
                          Get.snackbar(
                            "Validation Error",
                            errorMessage,
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );
                        } else if (selectedPet.value != null) {
                          promptBox.show(
                            context: context,
                            title: "Edit Pet Confirmation",
                            content: "Are you sure you want to edit this pet?",
                            onConfirm: () async {
                              await _petDetailsController.editPet(
                                selectedPet.value!.id,
                                petCategoryName.text,
                                petName.text,
                                petImageUrl.text,
                              );
                              Get.off(() => landingScreen(selectedIndex: 1,));
                            },
                          );
                        } else {
                          Get.snackbar(
                            "Selection Error",
                            "Please select a pet from the dropdown",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.redAccent,
                            colorText: Colors.white,
                          );
                        }
                      },
                      data: "Submit",
                      color: Colors.deepOrangeAccent,
                      size: 18,
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
