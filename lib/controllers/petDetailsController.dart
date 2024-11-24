import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_nest/screens/landingScreen.dart';
import 'package:pet_nest/utils/apiEndpoint.dart';
import 'package:http/http.dart' as http;

class Pet {
  final int id;
  final String name;
  final String category;
  final String imageUrl;

  Pet({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      name: json['name'],
      category: json['category']['name'],
      imageUrl: json['photoUrls'][0],
    );
  }
}

class petDetailsController extends GetxController {

  // list for state management
  var availablePetList = <Pet>[].obs;
  var soldPetList = <Pet>[].obs;

  int orderID = 0;
  int id = 0;

  Future<void> getAvailablePetDetails() async {
    try {
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.getPetByStatusAvailable);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        availablePetList.value = data.map((pet) => Pet.fromJson(pet)).toList();
      } else {
        print("Failed to fetch pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while fetching pet details: $e");
    }
  }

  Future<void> getSoldPetDetails() async {
    try {
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.getPetByStatusSold);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        soldPetList.value = data.map((pet) => Pet.fromJson(pet)).toList();
      } else {
        print("Failed to fetch sold pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while fetching sold pet details: $e");
    }
  }

  Future<void> addPet(String categoryName, String name, String imageUrl) async {
    try {
      id++;
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.addPet);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      Map<String, dynamic> body = {
        "id": id,
        "category": {
          "id": 1,
          "name": categoryName,
        },
        "name": name,
        "photoUrls": [imageUrl],
        "status": "bharathiRMPSavailable",
      };

      http.Response response = await http.post(url, body: jsonEncode(body),  headers: headers);

      if (response.statusCode == 200) {
        print("Pet added succesfully");
        Get.snackbar(
          "Success",
          "Added Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
        Get.off(() => landingScreen());
      } else {
        print("Failed to add pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      id--;
      print("Error while adding pet details: $e");
    }
  }

  Future<void> editPet(int id, String categoryName, String name, String imageUrl) async {
    try {
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.editPet);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      Map<String, dynamic> body = {
        "id": id,
        "category": {
          "id": 1,
          "name": categoryName,
        },
        "name": name,
        "photoUrls": [imageUrl],
        "status": "bharathiRMPSavailable",
      };

      http.Response response = await http.put(url, body: jsonEncode(body),  headers: headers);

      if (response.statusCode == 200) {
        print("Pet edited succesfully");
        Get.snackbar(
          "Success",
          "Edited Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
        Get.off(() => landingScreen());
      } else {
        print("Failed to edit pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while editing pet details: $e");
    }
  }

  Future<void> deletePet(int id) async {
    try {
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.deletePet + id.toString());
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.delete(url,  headers: headers);

      if (response.statusCode == 200) {
        print("Pet deleted succesfully");
        Get.snackbar(
          "Success",
          "Deleted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
        Get.off(() => landingScreen());
      } else {
        print("Failed to delete pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while deleting pet details: $e");
    }
  }

  Future<void> adoptPet(int petId) async {
    try {
      orderID++;
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.storeEndpoints.placeOrder);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      Map body = {
        "id": orderID,
        "petId": petId,
        "quantiy": 5,
        "status": "bharathiRMPSsold",
        "complete": true
      };

      http.Response response = await http.post(url, body: jsonEncode(body) ,headers: headers);

      if (response.statusCode == 200) {
        print("Pet adopted succesfully");
        Get.snackbar(
          "Success",
          "Adopted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
        Get.off(() => landingScreen());
      } else {
        print("Failed to adopt pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while adopting pet details: $e");
    }
  }

}

