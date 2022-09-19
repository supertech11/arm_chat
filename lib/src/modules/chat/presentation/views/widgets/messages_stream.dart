import 'package:arm_chat/src/modules/chat/presentation/views/widgets/chat_bubble.dart';
import 'package:arm_chat/src/modules/onboarding/presentation/logic/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessagesStream extends StatelessWidget {
  MessagesStream({
    Key? key,
  }) : super(key: key);
  final AuthController _authController = Get.find();

  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          _firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<ChatBubble> chatBubbles = [];
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');

          final currentUser = _authController.loggedInUser?.email;

          final chatBubble = ChatBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );

          chatBubbles.add(chatBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            children: chatBubbles,
          ),
        );
      },
    );
  }
}
