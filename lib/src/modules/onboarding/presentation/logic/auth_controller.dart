import 'package:arm_chat/src/core/analytics/app_analytic_event.dart';
import 'package:arm_chat/src/core/analytics/app_analytics.dart';
import 'package:arm_chat/src/core/utils/util_functions.dart';
import 'package:arm_chat/src/modules/chat/chat_module.dart';
import 'package:arm_chat/src/modules/onboarding/data/models/user_model.dart';
import 'package:arm_chat/src/modules/onboarding/onboarding_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? loggedInUser;
  GlobalKey<FormState> loginFormKey = GlobalKey();
  final isLoginFormDataValid = false.obs;
  final isLoginLoading = false.obs;
  UserModel user = UserModel.empty();

  GlobalKey<FormState> regFormKey = GlobalKey();
  final isRegFormDataValid = false.obs;
  final isRegLoading = false.obs;
  TextEditingController passwordController = TextEditingController();

  void validateLoginData() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    } else {
      isLoginFormDataValid.value = true;
    }
  }

  void loginUser() async {
    loginFormKey.currentState!.save();

    isLoginLoading.value = true;

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      loggedInUser = userCredential.user;
      AppAnalytics.it.setCurrentUserIdentity(user.email);
      AppAnalytics.it.logEvent(
        AppAnalyticEvent(name: "user_login", parameters: {
          "user_email": user.email,
        }),
      );
      Get.offNamedUntil(ChatModule.chatScreen.name, (route) => false);
    } on FirebaseAuthException catch (error) {
      UtilFunctions.displayErrorBox(error.message.toString());
    } catch (error) {
      UtilFunctions.displayErrorBox(error.toString());
    } finally {
      isLoginLoading.value = false;
    }
  }

  void getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  void validateRegData() async {
    if (!regFormKey.currentState!.validate()) {
      return;
    } else {
      isRegFormDataValid.value = true;
    }
  }

  void createAccount() async {
    regFormKey.currentState!.save();

    isRegLoading.value = true;

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      loggedInUser = userCredential.user;
      createUser(user, userCredential.credential?.providerId);
      user.password = "";
      passwordController.text = "";
      AppAnalytics.it.setCurrentUserIdentity(user.email);
      Get.offNamedUntil(ChatModule.chatScreen.name, (route) => false);
    } on FirebaseAuthException catch (error) {
      UtilFunctions.displayErrorBox(error.message.toString());
    } catch (error) {
      UtilFunctions.displayErrorBox(error.toString());
    } finally {
      isRegLoading.value = false;
    }
  }

  void createUser(UserModel user, String? uid) {
    _firestore.collection('users').doc(uid).set({
      'firstname': user.firstname,
      'lastname': user.lastname,
      'email': user.email,
    });
  }

  Future<bool> tryAutoLogin() async {
    getCurrentUser();
    if (loggedInUser == null) {
      Get.offNamed(OnboardingModule.walkThroughScreen.name);
      return false;
    }
    AppAnalytics.it.setCurrentUserIdentity(loggedInUser!.email!);
    AppAnalytics.it.logEvent(
      AppAnalyticEvent(name: "user_login", parameters: {
        "user_email": loggedInUser?.email,
      }),
    );

    Get.offNamedUntil(ChatModule.chatScreen.name, (route) => false);

    return true;
  }

  void logout() async {
    await _auth.signOut();
    AppAnalytics.it.logEvent(
      AppAnalyticEvent(name: "user_logs_out", parameters: {
        "user_email": loggedInUser?.email,
      }),
    );
    loggedInUser = null;
    Get.offAllNamed(OnboardingModule.walkThroughScreen.name);
  }
}
