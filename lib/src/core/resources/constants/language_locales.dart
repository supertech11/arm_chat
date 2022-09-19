import 'package:arm_chat/src/core/resources/string/app_image_assets.dart';
import 'package:arm_chat/src/modules/onboarding/data/models/language.dart';

// ignore: non_constant_identifier_names
List<Language> LanguageLocales = [
  Language(
    englishName: "English",
    shortName: "ENG",
    locale: "en",
    logoUrl: AppImageAssets.en,
  ),
  Language(
    englishName: "Spanish",
    shortName: "ES",
    locale: "es",
    logoUrl: AppImageAssets.es,
  ),
];
