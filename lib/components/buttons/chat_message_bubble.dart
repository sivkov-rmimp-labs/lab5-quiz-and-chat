import 'package:flutter/material.dart';
import 'package:lab5_quiz_and_chat/data/chat_item.dart';
import 'package:lab5_quiz_and_chat/extensions.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatItem chatItem;

  const ChatMessageBubble({Key? key, required this.chatItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.brighten(10),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (chatItem.image != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: chatItem.image!,
                ),
                const SizedBox(height: 10),
              ],
              Align(
                alignment: Alignment.centerLeft,
                child: Text(chatItem.message),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Opacity(
                  opacity: 0.6,
                  child: Text(chatItem.authorName),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
