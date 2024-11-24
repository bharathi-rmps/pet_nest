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

  petDetailsController _petDetailsController = Get.put(petDetailsController());

  @override
  Widget build(BuildContext context) {
    _petDetailsController.getPetDetails();
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

                      // Cards Grid
                      Obx(() {
                          if(_petDetailsController.petList.isEmpty){
                            return const Center(child: CircularProgressIndicator());
                          }
                          return cardContent(pets: _petDetailsController.petList);
                      }

                      ),
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
}

// Search Bar Component
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
