import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/promptBox.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';
import 'package:pet_nest/screens/landingScreen.dart';

import '../../../components/profileFields.dart';

class deletePetScreen extends StatelessWidget {
  final TextEditingController petCategoryName = TextEditingController();
  final TextEditingController petName = TextEditingController();
  final TextEditingController petImageUrl = TextEditingController();

  final petDetailsController _petDetailsController = Get.find<petDetailsController>();
  final Rx<Pet?> selectedPet = Rx<Pet?>(null);

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
        title: Text("Delete Pet"),
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
                    "lib/assets/delete pet banner.png",
                    fit: BoxFit.cover,
                  ),
                ),

                //text
                SizedBox(height: 20,),
                const Text(
                  "Please Select the Pet and Delete",
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

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Obx(() {
                        if (selectedPet.value != null) {
                          return Column(
                            children: [
                              profileFields(
                                title: "Pet Category",
                                subTitle: selectedPet.value!.category,
                                isObscured: false,
                              ),
                              const SizedBox(height: 15),
                              profileFields(
                                title: "Pet Name",
                                subTitle: selectedPet.value!.name,
                                isObscured: false,
                              ),
                              const SizedBox(height: 15),
                            ],
                          );
                        } else {
                          return const SizedBox(); // Return an empty space if no pet is selected.
                        }
                      }),



                    ],
                  ),

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
                            title: "Delete Pet Confirmation",
                            content: "Are you sure you want to delete this pet?",
                            onConfirm: () async {
                              await _petDetailsController.deletePet(
                                  selectedPet.value!.id
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
                      data: "Delete",
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
