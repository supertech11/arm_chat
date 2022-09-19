import 'package:arm_chat/src/core/analytics/app_analytic_event.dart';
import 'package:arm_chat/src/core/analytics/app_analytics.dart';
import 'package:arm_chat/src/core/components/custom_elevated_button.dart';
import 'package:arm_chat/src/core/components/custom_text.dart';
import 'package:arm_chat/src/core/resources/colors/pallet.dart';
import 'package:arm_chat/src/core/resources/string/string_constant.dart';
import 'package:arm_chat/src/modules/chat/presentation/views/widgets/messages_stream.dart';
import 'package:arm_chat/src/modules/onboarding/presentation/logic/auth_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final AuthController _authController = Get.find();
  final messageTextController = TextEditingController();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? messageText;

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
    _firebaseMessaging.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              onPressed: () {
                _authController.logout();
              }),
        ],
        title: CustomText(
          text: StringConfig.text.armChat,
          color: Pallet.white,
          weight: FontWeight.bold,
          size: 14,
        ),
        backgroundColor: Pallet.primary,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Pallet.primary, width: 2.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: StringConfig.text.typeMessageHere,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      if (messageTextController.text.isNotEmpty) {
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'sender': _authController.loggedInUser?.email,
                          'timestamp': Timestamp.now(),
                        });
                        messageTextController.clear();
                        AppAnalytics.it.logEvent(
                          AppAnalyticEvent(name: "user_send_msg", parameters: {
                            "user_email": _authController.loggedInUser?.email,
                          }),
                        );
                      }
                    },
                    label: StringConfig.text.send,
                    key: const Key("send_chat_text"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
