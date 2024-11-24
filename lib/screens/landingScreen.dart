import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/controllers/sessionController.dart';
import 'package:pet_nest/screens/mainScreens/profileScreen.dart';
import 'package:pet_nest/screens/mainScreens/shopScreen.dart';

import '../controllers/navigationController.dart';

class landingScreen extends StatelessWidget  {
  landingScreen({super.key});

  final sessionController _sessionController = Get.put(sessionController());
  final navigationController _navigationController = Get.put(navigationController());

  @override
  Widget build(BuildContext context) {
    if (_sessionController.isLoggedIn.value) {
      _navigationController.selectedIndex.value = 0;
    }
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(() {
        // Update body content based on selected index
        switch (_navigationController.selectedIndex.value) {
          case 0:
            return shopScreen();
          case 1:
            return Center(
                child: Text('Manage Pet')
            );
          case 2:
            return Center(
                child: Text('Cart Page')
            );
          case 3:
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
          selectedItemColor: Colors.deepOrangeAccent,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Shop'),
            BottomNavigationBarItem(icon: Icon(Icons.pets), label: 'Manage Pet'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(Icons.account_box), label: 'Profile'),
          ],
        );
      }),
    );
  }
}
