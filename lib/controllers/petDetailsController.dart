import 'dart:convert';
import 'dart:math';
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

  @override
  void onInit() {
    super.onInit();
    getPetDetails();
  }

  // list for state management
  var availablePetList = <Pet>[].obs;
  var soldPetList = <Pet>[].obs;

  var isLoading = false.obs;
  int id = 0;

  int petIdGenerator(int id){
    var randNum = Random();
    id = randNum.nextInt(3000);
    return id;
  }


  Future<void> getPetDetails() async {
    try {
      isLoading.value = true;
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.getPetByTags);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        availablePetList.value = data
            .where((pet) => pet['status'] == 'available')
            .map((pet) => Pet.fromJson(pet))
            .toList();

        soldPetList.value = data
            .where((pet) => pet['status'] == 'sold')
            .map((pet) => Pet.fromJson(pet))
            .toList();

        //print("Available pets: ${availablePetList.length}");
        //print("Sold pets: ${soldPetList.length}");
      } else {
        Get.snackbar(
          "Error",
          "Error Details",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
        //print("Failed to fetch pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error Details, $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
      //print("Error while fetching pet details: $e");
    } finally{
      isLoading.value = false;
    }
  }

  Future<void> addPet(String categoryName, String name, String imageUrl) async {
    try {
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.addPet);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      Map<String, dynamic> body = {
        "id": petIdGenerator(id),
        "category": {
          "id": 1,
          "name": categoryName,
        },
        "name": name,
        "photoUrls": [imageUrl],
        "tags": [ {
          "id": 1,
          "name": "bharathiRMPSavailable"
          },
        ],
        "status": "available",
      };

      http.Response response = await http.post(url, body: jsonEncode(body),  headers: headers);

      if (response.statusCode == 200) {
        //print("Pet added succesfully,"+ response.body);
        Get.snackbar(
          "Success",
          "Added Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
      } else {
        Get.snackbar(
          "Error",
          "Error Details",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
        //print("Failed to add pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error Details, $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
      //print("Error while adding pet details: $e");
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
        "tags": [ {
          "id": 1,
          "name": "bharathiRMPSavailable"
        },
        ],
        "status": "available",
      };

      http.Response response = await http.put(url, body: jsonEncode(body),  headers: headers);

      if (response.statusCode == 200) {
        //print("Pet edited succesfully");
        Get.snackbar(
          "Success",
          "Edited Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
      } else {
        Get.snackbar(
          "Error",
          "Error Details",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
        //print("Failed to edit pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error Details, $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
      //print("Error while editing pet details: $e");
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
        //print("Pet deleted succesfully");
        Get.snackbar(
          "Success",
          "Deleted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
      } else {
        Get.snackbar(
          "Error",
          "Error Details",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
        //print("Failed to delete pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error Details, $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
      //print("Error while deleting pet details: $e");
    }
  }

  Future<void> adoptPet(int petId, String categoryName, String name, String imageUrl) async {
    try {
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.editPet);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      Map<String, dynamic> body = {
        "id": petId,
        "category": {
          "id": 1,
          "name": categoryName,
        },
        "name": name,
        "photoUrls": [imageUrl],
        "tags": [ {
          "id": 1,
          "name": "bharathiRMPSavailable"
        },
        ],
        "status": "sold",
      };

      http.Response response = await http.post(url, body: jsonEncode(body) ,headers: headers);

      if (response.statusCode == 200) {

        // remove pet from available list
        availablePetList.removeWhere((pet) => pet.id == petId);

        // add the pet to the sold list (if needed)
        soldPetList.add(Pet(id: petId, category: categoryName, name: name, imageUrl: imageUrl));

        //print("Pet adopted succesfully");
        Get.snackbar(
          "Success",
          "Adopted Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.colorScheme.primaryContainer,
        );
      } else {
        Get.snackbar(
          "Error",
          "Error Details",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.primaryColorLight,
        );
        //print("Failed to adopt pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Error Details, $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.primaryColorLight,
      );
      //print("Error while adopting pet details: $e");
    }
  }

}

