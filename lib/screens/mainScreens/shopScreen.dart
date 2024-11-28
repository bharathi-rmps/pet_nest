import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/cardContent.dart';
import 'package:pet_nest/components/contentForAll.dart';
import 'package:pet_nest/components/contentForCategory.dart';
import 'package:pet_nest/components/contentForRecents.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/futureFeature.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';


class shopScreen extends StatelessWidget {

  final selectedButton = 0.obs;
  petDetailsController _petDetailsController = Get.put(petDetailsController());
  final RxString searchQuery = ''.obs;
  final RxBool showSearchContent = false.obs;
  TextEditingController searchBarText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [

            // static Search Bar
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Obx(() => TextField(
                      controller: searchBarText,
                      onChanged: (value) {
                        searchQuery.value = value.trim().toLowerCase();
                        showSearchContent.value = value.isNotEmpty;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        labelText: "Search by Category",
                        border: OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: searchQuery.value.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.cancel),
                          onPressed: () {
                            searchQuery.value = "";
                            searchBarText.clear();
                            FocusScope.of(context).unfocus();
                            showSearchContent.value = false;
                          },
                        ) : null,
                      ),
                    )),
                  ),
                ],
              ),
            ),

            // scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // Banner Image
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
                          "lib/assets/petnest banner.png",
                          fit: BoxFit.cover,
                        ),
                      ),

                      // pets list buttons
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          //all button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Obx(() => elevatedButtons(
                              onPressed: () {
                                selectedButton.value = 0;
                              },
                              data: "All",
                              color: selectedButton.value == 0 ? Colors.deepOrangeAccent : Colors.grey,
                              size: 14,
                             ),
                            ),
                          ),

                          // category button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Obx(() => elevatedButtons(
                              onPressed: () {
                                selectedButton.value = 1;
                              },
                              data: "Category",
                              color: selectedButton.value == 1 ? Colors.deepOrangeAccent : Colors.grey,
                              size: 14,
                            ),
                           ),
                          ),

                          // recents button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Obx(() => elevatedButtons(
                              onPressed: () {
                                selectedButton.value = 2;
                              },
                              data: "Recents",
                              color: selectedButton.value == 2 ? Colors.deepOrangeAccent : Colors.grey,
                              size: 14,
                            ),
                           ),
                          ),

                        ],
                      ),

                      // cards
                      const SizedBox(height: 15),
                      Obx(() {

                        // search result cards
                        if (showSearchContent.value) {
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: _buildSearchResults(searchQuery.value),
                          );
                        }

                        // all cards
                        else {
                          if (selectedButton.value == 0) {
                            return contentForAll();
                          } else if (selectedButton.value == 1) {
                            return contentForCategory();
                          } else if (selectedButton.value == 2) {
                            return contentForRecents();
                          }
                          return const Text("Unknown Selection");
                        }

                      }),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(String query) {

    // filter pets based on category
    final filteredPets = _petDetailsController.availablePetList
        .where((pet) => pet.category.toLowerCase().contains(query))
        .toList();

    if (filteredPets.isEmpty) {
      return const Center(
        child: Text(
          "No pets found for the entered category.",
          style: TextStyle(fontSize: 16),
        ),
      );

    }

    return cardContent(
      pets: filteredPets,
      showButton: true,
      height: 0.7,
      addOrAdoptUsername: "Added By : ",
    );
  }

}

// search bar component
class SearchBar extends StatelessWidget {
  final VoidCallback? onTap;

  const SearchBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Text(
              'Search',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

}

