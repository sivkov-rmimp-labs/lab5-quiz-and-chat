import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ImageAdapter extends TypeAdapter<Image> {
  @override
  int get typeId => 2;

  @override
  Image read(BinaryReader reader) {
    final type = reader.readByte();
    if (type == 0) {
      // 0 => local file path
      final path = reader.readString();
      return Image.file(File(path));
    }
    if (type == 1) {
      // 1 => network uri
      final uri = reader.readString();
      return Image.network(uri);
    }
    throw Exception("Unknown type in saved Hive Image: $type");
  }

  @override
  void write(BinaryWriter writer, Image obj) {
    if (obj.image is FileImage) {
      // Local file path
      writer.writeByte(0);
      writer.writeString((obj.image as FileImage).file.path);
    } else if (obj.image is NetworkImage) {
      // Network uri
      writer.writeByte(1);
      writer.writeString((obj.image as NetworkImage).url);
    } else {
      throw Exception("Unknown image type to be saved: ${obj.image.runtimeType}");
    }
  }
}
