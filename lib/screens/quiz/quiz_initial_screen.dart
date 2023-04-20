import 'package:flutter/material.dart';
import 'package:lab5_quiz_and_chat/components/buttons/my_filled_button.dart';
import 'package:lab5_quiz_and_chat/main.dart';
import 'package:lab5_quiz_and_chat/screens/base_screen.dart';
import 'package:lab5_quiz_and_chat/screens/quiz/quiz_screen.dart';

class QuizInitialScreen extends StatefulWidget implements Screen {
  const QuizInitialScreen({Key? key}) : super(key: key);

  @override
  State<QuizInitialScreen> createState() => _QuizInitialScreenState();

  @override
  final int bottomNavigationBarButtonIndex = 0;

  @override
  String get appBarTitle => 'Викторина';

  @override
  List<AppBarAction> get appBarActions => [];
}

class _QuizInitialScreenState extends State<QuizInitialScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Предлагаем вам сыграть в нашу юбилейную викторину, ответьте на десять вопросов о лисах и станьте победителем',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: MyFilledButton(
              title: 'Начать игру',
              onClick: () {
                changeScreen(const QuizScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
