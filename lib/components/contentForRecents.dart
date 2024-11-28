import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/cardContent.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';

class contentForRecents extends StatelessWidget {

  petDetailsController _petDetailsController = Get.find<petDetailsController>();

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final timeThreshold = currentTime.subtract(const Duration(minutes: 5));

    return Container(
      child: Obx(() {

        // loading bar
        if (_petDetailsController.isLoading.value) {
          return _buildLoadingView();
        }

        // no pet found
        else if (_petDetailsController.availablePetList.isEmpty) {
          return _buildEmptyView();
        }

        // cards Grid
        else {
          return _buildPetList(timeThreshold);
        }
      })
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

  Widget _buildPetList(DateTime timeThreshold) {
    final recentPets = _petDetailsController.availablePetList
        .where((pet) => pet.time.isAfter(timeThreshold))
        .toList();

    if (recentPets.isEmpty) {
      return const Center(
        child: Column(
          children: [
            SizedBox(height: 80,),
            Text(
              "No Pets Added in Last 5 Minutes.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    return cardContent(
      pets: recentPets,
      showButton: true,
      height: 0.7,
      addOrAdoptUsername: "Added By : ",
    );
  }

}