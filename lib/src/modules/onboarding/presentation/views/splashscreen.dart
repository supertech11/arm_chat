import 'dart:async';

import 'package:arm_chat/src/core/resources/colors/pallet.dart';
import 'package:arm_chat/src/core/resources/string/app_image_assets.dart';
import 'package:arm_chat/src/modules/onboarding/presentation/logic/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late Timer timer;
  AuthController authController = Get.find();

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 2),
      () async {
        await authController.tryAutoLogin();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (timer.isActive) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Pallet.black,
        child: Center(
          child: Image.asset(
            AppImageAssets.logo,
            width: 200,
            height: 250,
          ),
        ),
      ),
    );
  }
}
