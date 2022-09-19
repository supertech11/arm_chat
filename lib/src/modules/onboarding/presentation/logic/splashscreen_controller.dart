import 'package:arm_chat/src/core/resources/constants/language_locales.dart';
import 'package:arm_chat/src/core/resources/string/app_image_assets.dart';
import 'package:arm_chat/src/modules/onboarding/data/models/language.dart';
import 'package:get/get.dart';

class SplashscreenController extends GetxController {
  Language defaultLanguage = Language(
      englishName: "English",
      shortName: "ENG",
      locale: "en",
      logoUrl: AppImageAssets.en);
  final languages = <Language>[].obs;
  final currentLanguage = Language(
    englishName: "English",
    shortName: "ENG",
    locale: "en",
    logoUrl: AppImageAssets.en,
  ).obs;

  @override
  void onInit() async {
    super.onInit();
    String? deviceCountrycode =
        Get.deviceLocale?.languageCode ?? defaultLanguage.locale;
    resetDeviceLanguage(deviceCountrycode);
  }

  void resetDeviceLanguage(String newLocale) {
    languages.value = LanguageLocales.map((e) {
      if (e.locale == newLocale) {
        e.isCurrent = true;
        currentLanguage.value = e;
      } else {
        e.isCurrent = false;
      }

      return e;
    }).toList();
  }
}
