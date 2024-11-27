import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/cardContent.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';

class contentForCategory extends StatelessWidget {

  petDetailsController _petDetailsController = Get.find<petDetailsController>();
  final Rx<String?> selectedCategory = Rx<String?>(null);

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: [

           //dropdown for category selection
           Obx(() {
             final categories = _petDetailsController.availablePetList
                 .map((pet) => pet.category.trim().toLowerCase())
                 .toSet()
                 .map((category) => capitalize(category))
                 .toList();
             //print("categories , "+ categories.toString());

             return DropdownButton<String>(
               hint: Text("Select a Category"),
               value: selectedCategory.value,
               onChanged: (String? newCategory) {
                 selectedCategory.value = newCategory;
               },
               items: categories
                   .map((category) => DropdownMenuItem<String>(
                 value: category,
                 child: Text(category),
               )).toList(),
             );
           }),

           // card output
           Obx(() {
             // loading bar
             if (_petDetailsController.isLoading.value) {
               return _buildLoadingView();
             }

             //no pet found
             else if (_petDetailsController.availablePetList.isEmpty) {
               return _buildEmptyView();
             }

             // cards Grid
             else if (selectedCategory.value == null) {
               return const Column(
                 children: [
                   SizedBox(height: 50,),
                   Text(
                     "Please Select an Category",
                     style: TextStyle(fontSize: 16),
                   ),
                 ],
               );
             } else {
               return _buildSelectedPetView(selectedCategory.value!);
             }
           })
         ],
       ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(height: 80),
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text(
            "Loading...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(height: 80),
          Icon(Icons.pets, size: 50, color: Colors.grey),
          SizedBox(height: 10),
          Text(
            "No Pet Found",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedPetView(String selectedCategory) {
    //print("seleceted categsos "+ selectedCategory);
    final petsInCategory = _petDetailsController.availablePetList
        .where((pet) => pet.category.trim().toLowerCase() == selectedCategory.trim().toLowerCase())
        .toList();

    return cardContent(
        pets: petsInCategory,
        showButton: true,
        height: 0.7);
  }
}