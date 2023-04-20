import 'package:flutter/material.dart';
import 'package:lab5_quiz_and_chat/components/buttons/my_filled_button.dart';
import 'package:lab5_quiz_and_chat/extensions.dart';
import 'package:lab5_quiz_and_chat/main.dart';
import 'package:lab5_quiz_and_chat/screens/base_screen.dart';
import 'package:lab5_quiz_and_chat/screens/quiz/quiz_screen.dart';

class QuizFinalScreen extends StatefulWidget implements Screen {
  final int correctlyAnsweredQuestionCount;

  const QuizFinalScreen({Key? key, required this.correctlyAnsweredQuestionCount}) : super(key: key);

  @override
  State<QuizFinalScreen> createState() => _QuizFinalScreenState();

  @override
  final int bottomNavigationBarButtonIndex = 1;

  @override
  String get appBarTitle => 'Викторина';

  @override
  List<AppBarAction> get appBarActions => [];
}

class _QuizFinalScreenState extends State<QuizFinalScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            '🎉',
            style: TextStyle(fontSize: 72),
          ),
          const Text(
            'Поздравляем!',
            style: TextStyle(fontSize: 26),
          ),
          Text(
            'Вы ответили на ${widget.correctlyAnsweredQuestionCount.decline('вопрос', 'вопроса', 'вопросов')} из ${quizItems.length}.\n'
            'Можно сказать, что вы хорошо знаете нашу компанию!',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
