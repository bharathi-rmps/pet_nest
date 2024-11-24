import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  var petList = <Pet>[].obs;

  Future<void> getPetDetails() async {
    try {
      var url = Uri.parse(apiEndpoint.baseUrl + apiEndpoint.petEndpoints.getPetByStatus);
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        petList.value = data.map((pet) => Pet.fromJson(pet)).toList();
      } else {
        print("Failed to fetch pet details. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while fetching pet details: $e");
    }
  }
}
