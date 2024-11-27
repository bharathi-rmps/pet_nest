import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/components/cardContent.dart';
import 'package:pet_nest/controllers/petDetailsController.dart';

class contentForAll extends StatelessWidget {

  petDetailsController _petDetailsController = Get.find<petDetailsController>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Obx(() {

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