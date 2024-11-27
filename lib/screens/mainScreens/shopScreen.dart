import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/contentForAll.dart';
import 'package:pet_nest/components/contentForCategory.dart';
import 'package:pet_nest/components/contentForRecents.dart';
import 'package:pet_nest/components/elevatedButtons.dart';
import 'package:pet_nest/components/futureFeature.dart';


class shopScreen extends StatelessWidget {

  final selectedButton = 0.obs;

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

                          //category button
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

                          //recents button
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
                        if (selectedButton.value == 0) {
                          return contentForAll();
                        } else if (selectedButton.value == 1) {
                          return contentForCategory();
                        } else if (selectedButton.value == 2) {
                          return contentForRecents();
                        }
                        return const Text("Unknown Selection");
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

