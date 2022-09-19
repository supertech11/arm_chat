import 'package:arm_chat/localization/translations/es.dart';
import 'package:get/get.dart';
import 'package:arm_chat/localization/translations/en_us.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': enUs,
        'es': es,
      };
}
