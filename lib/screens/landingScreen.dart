import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/screens/auth/loginUser.dart';
import 'package:pet_nest/controllers/sessionController.dart';
import 'package:pet_nest/screens/profileScreen.dart';

import '../controllers/navigationController.dart';

class landingScreen extends StatelessWidget  {
  landingScreen({super.key});

  final sessionController _sessionController = Get.put(sessionController());
  final navigationController _navigationController = Get.put(navigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        // Update body content based on selected index
        switch (_navigationController.selectedIndex.value) {
          case 0:
            return Center(
                child: Text('Shop Page')
            );
          case 1:
            return Center(
                child: Text('Cart Page')
            );
          case 2:
            return profileScreen();
          default:
            return Center(
                child: Text('Unknown Page')
            );
        }
      }),
      bottomNavigationBar: Obx(() {
        // Update BottomNavigationBar dynamically
        return BottomNavigationBar(
          currentIndex: _navigationController.selectedIndex.value,
          onTap: (index) {
            _navigationController.changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Shop'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Profile'),
          ],
        );
      }),
    );
  }
}
