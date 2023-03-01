import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lab5_quiz_and_chat/components/buttons/chat_message_bubble.dart';
import 'package:lab5_quiz_and_chat/components/buttons/my_filled_button.dart';
import 'package:lab5_quiz_and_chat/data/chat_item.dart';
import 'package:lab5_quiz_and_chat/main.dart';
import 'package:lab5_quiz_and_chat/screens/base_screen.dart';
import 'package:lab5_quiz_and_chat/screens/chat/your_message_screen.dart';
import 'package:lab5_quiz_and_chat/screens/quiz/quiz_screen.dart';

class ChatListScreen extends StatefulWidget implements Screen {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();

  @override
  final int bottomNavigationBarButtonIndex = 1;

  @override
  String get appBarTitle => 'Живой чат';

  @override
  List<AppBarAction> get appBarActions => [
        AppBarAction(
          onTap: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const YourMessageScreen();
                },
              ),
            );
          },
          icon: Icons.edit,
        ),
      ];
}

var lastUsedAuthorName = '';

final messagesUpdateNotifier = ChangeNotifier();

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: messagesUpdateNotifier,
          builder: (ctx, _) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: Hive.box<ChatItem>('chat').values.reverse().map((m) => ChatMessageBubble(chatItem: m)).toList(),
          ),
        ),
      ),
    );
  }
}

