import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lab5_quiz_and_chat/components/buttons/my_filled_button.dart';
import 'package:lab5_quiz_and_chat/data/chat_item.dart';
import 'package:lab5_quiz_and_chat/main.dart';
import 'package:lab5_quiz_and_chat/screens/chat/chat_list_screen.dart';

class YourMessageScreen extends StatefulWidget {
  const YourMessageScreen({Key? key}) : super(key: key);

  @override
  State<YourMessageScreen> createState() => _YourMessageScreenState();
}

class _YourMessageScreenState extends State<YourMessageScreen> {
  final _nameController = TextEditingController(text: lastUsedAuthorName);
  final _messageController = TextEditingController();
  Image? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createAppBar(
        context: context,
        title: 'Ваше сообщение',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Ваше имя',
                        hintText: 'Например, Иванов Иван Иванович',
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 0.04),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      controller: _nameController,
                      onChanged: (newValue) => setState(() {}),
                    ),
                    const SizedBox(height: 25),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Сообщение',
                        hintText: 'Можете написать краткое предложение про любимых животных',
                        filled: true,
                        fillColor: Color.fromRGBO(255, 255, 255, 0.04),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      minLines: 4,
                      maxLines: 8,
                      controller: _messageController,
                      onChanged: (newValue) => setState(() {}),
                    ),
                    const SizedBox(height: 25),
                    if (image != null) ...[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            child: image!,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IntrinsicWidth(
                        child: OutlinedButton(
                          onPressed: () {
                            _pickImage(context);
                          },
                          style: ButtonStyle(
                            side: MaterialStatePropertyAll(
                              BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                Icon(image == null ? Icons.add : Icons.sync,
                                    color: Theme.of(context).colorScheme.primary),
                                Text(image == null ? 'Прикрепить фото...' : 'Заменить фото...'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            MyFilledButton(
              title: 'Отправить сообщение',
              enabled: _nameController.text.trim().isNotEmpty && _messageController.text.trim().isNotEmpty,
              clickableWhenDisabled: true,
              onClick: () {
                final errors = <String>[];
                if (_nameController.text.trim().isEmpty) {
                  errors.add('Ваше имя не может быть пустым');
                }
                if (_messageController.text.trim().isEmpty) {
                  errors.add('Сообщение не может быть пустым');
                }

                if (errors.isNotEmpty) {
                  final errorMessage = errors.join('\n');
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(errorMessage),
                    duration: const Duration(seconds: 2),
                  ));
                  return;
                }

                lastUsedAuthorName = _nameController.text;

                Hive.box<ChatItem>('chat').add(
                  ChatItem(
                    authorName: _nameController.text,
                    message: _messageController.text,
                    image: image,
                  ),
                );
                messagesUpdateNotifier.notifyListeners();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _pickImage(BuildContext context) {
    print('Showing dialog for source');
    showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        content: const Text('Выберите источник картинки'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx, ImageSource.camera);
              },
              child: const Text('Камера')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx, ImageSource.gallery);
              },
              child: const Text('Галерея')),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                showDialog(
                  context: context,
                  builder: (context) {
                    final controller = TextEditingController();
                    return AlertDialog(
                      title: const Text('Ссылка на картинку'),
                      content: TextField(
                        decoration: const InputDecoration(labelText: 'Ссылка'),
                        controller: controller,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            final maybeUrl = Uri.tryParse(controller.text);
                            if (maybeUrl == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Введенный текст не является ссылкой!'),
                                ),
                              );
                              return;
                            }

                            setState(() {
                              Navigator.pop(context);
                              image = Image.network(maybeUrl.toString());
                            });
                          },
                          child: const Text('ОК'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Отмена'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Ссылка')),
        ],
      ),
    ).then((imageSource) async {
      print('Showed dialog for source');
      if (imageSource != null) {
        print('Picking file with image source = $imageSource...');
        final pickedFile = await ImagePicker().pickImage(source: imageSource);
        if (pickedFile != null) {
          print('Picked file: "${pickedFile.path}"...');
          setState(() {
            image = Image.file(File(pickedFile.path));
          });
        }
      }
    });
  }
}
