import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/promptBox.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';
import 'package:pet_nest/screens/landingScreen.dart';

import '../../../components/textField.dart';

class deletePetScreen extends StatelessWidget {
  final TextEditingController petCategoryName = TextEditingController();
  final TextEditingController petName = TextEditingController();
  final TextEditingController petImageUrl = TextEditingController();

  final petDetailsController _petDetailsController = Get.put(petDetailsController());
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
        title: Text("Edit Your Pet"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            children: [
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
                      Get.off(() => landingScreen());
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
                          onConfirm: () {
                            _petDetailsController.deletePet(
                              selectedPet.value!.id
                            );
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
    );
  }
}
