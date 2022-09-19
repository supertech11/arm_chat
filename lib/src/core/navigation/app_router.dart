import 'package:arm_chat/src/modules/chat/chat_module.dart';
import 'package:arm_chat/src/modules/module.dart';
import 'package:arm_chat/src/modules/onboarding/onboarding_module.dart';
import 'package:get/get.dart';

class AppRouter {
  AppRouter._();

  static AppRouter get it => AppRouter._();

  String get initialRoute => OnboardingModule.splashScreen.name;

  static final _modules = <Module>[
    OnboardingModule(),
    ChatModule(),
  ];

  List<GetPage> get all {
    final routes = <GetPage>[];
    for (var module in _modules) {
      module.register(routes);
    }
    return routes;
  }
}
