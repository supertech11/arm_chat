import 'package:arm_chat/src/modules/chat/bindings/chat_binding.dart';
import 'package:arm_chat/src/modules/chat/presentation/views/chat_screen.dart';
import 'package:arm_chat/src/modules/module.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'package:get/get.dart';

class ChatModule extends Module {
  static final chatScreen = GetPage(
    name: '/chatscreen',
    page: () => const ChatScreen(),
    binding: ChatBinding(),
  );

  @override
  void register(List<GetPage> routes) {
    routes.addAll([
      chatScreen,
    ]);
  }
}
