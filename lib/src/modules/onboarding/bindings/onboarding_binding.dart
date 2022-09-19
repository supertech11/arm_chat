import 'package:arm_chat/src/modules/onboarding/presentation/logic/auth_controller.dart';
import 'package:arm_chat/src/modules/onboarding/presentation/logic/splashscreen_controller.dart';
import 'package:arm_chat/src/modules/onboarding/presentation/logic/walkthrough_controller.dart';
import 'package:get/get.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => WalkthroughController(), fenix: true);
    Get.lazyPut(() => SplashscreenController(), fenix: true);
  }
}
