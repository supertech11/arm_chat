import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UtilFunctions {
  static void displayErrorBox(String message) {
    Get.snackbar(
      'Error!',
      message,
      barBlur: 0,
      dismissDirection: DismissDirection.vertical,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      overlayBlur: 0,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 3),
    );
  }

  static void displaySuccessBox(String heading, String message) {
    Get.snackbar(
      heading,
      message,
      barBlur: 0,
      dismissDirection: DismissDirection.vertical,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      overlayBlur: 0,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 3),
    );
  }
}
