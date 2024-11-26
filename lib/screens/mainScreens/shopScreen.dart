import 'package:flutter/material.dart';
import 'package:pet_nest/components/cardContent.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/futureFeature.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';
import 'package:get/get.dart';

class shopScreen extends StatelessWidget {

  // Lists for card data
  late final List<String> imageList;
  late final List<String> petCategoryList;
  late final List<String> petNameList;

  final petDetailsController _petDetailsController = Get.find<petDetailsController>();

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
                    child: SearchBar(
                      onTap: () {
                        futureFeature();
                      },
                    ),
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
                      const SizedBox(height: 15),

                      // Pets List Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: elevatedButtons(
                              onPressed: () {
                                futureFeature();
                              },
                              data: "All",
                              color: Colors.deepOrangeAccent,
                              size: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: elevatedButtons(
                              onPressed: () {
                                futureFeature();
                              },
                              data: "Category",
                              color: Colors.grey,
                              size: 14,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: elevatedButtons(
                              onPressed: () {
                                futureFeature();
                              },
                              data: "Recents",
                              color: Colors.grey,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // check if data is still loading
                      Obx(() {

                        // loading bar
                        if (_petDetailsController.isLoading.value) {
                          return _buildLoadingView();
                        }

                        //no pet found
                        else if (_petDetailsController.availablePetList.isEmpty) {
                          return _buildEmptyView();
                        }

                        // Cards Grid
                        else {
                          return _buildPetList();
                        }
                      })

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

  Widget _buildPetList() {
    return cardContent(
      pets: _petDetailsController.availablePetList,
      showButton: true,
      height: 0.7,
    );
  }

}

// search Bar Component
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

