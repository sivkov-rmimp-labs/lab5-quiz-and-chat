import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

part 'chat_item.g.dart';

@HiveType(typeId: 1)
class ChatItem extends HiveObject {
  @HiveField(0)
  final String authorName;

  @HiveField(1)
  final String message;

  @HiveField(2)
  final Image? image;

  ChatItem({required this.authorName, required this.message, this.image});
}
