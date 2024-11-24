import 'package:flutter/material.dart';
import 'package:get/get.dart';

void futureFeature() {
  Get.snackbar(
    "Under Development",
    "This feature will be available shortly",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.deepOrangeAccent,
    colorText: Colors.white,
  );
}
