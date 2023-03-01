// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatItemAdapter extends TypeAdapter<ChatItem> {
  @override
  final int typeId = 1;

  @override
  ChatItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatItem(
      authorName: fields[0] as String,
      message: fields[1] as String,
      image: fields[2] as Image?,
    );
  }

  @override
  void write(BinaryWriter writer, ChatItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.authorName)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
