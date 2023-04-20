import 'dart:math';

import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:lab5_quiz_and_chat/components/buttons/my_filled_button.dart';
import 'package:lab5_quiz_and_chat/components/buttons/quiz_answer_button.dart';
import 'package:lab5_quiz_and_chat/data/quiz_item.dart';
import 'package:lab5_quiz_and_chat/main.dart';
import 'package:lab5_quiz_and_chat/screens/base_screen.dart';
import 'package:lab5_quiz_and_chat/screens/quiz/quiz_final_screen.dart';

class QuizScreen extends StatefulWidget implements Screen {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();

  @override
  final int bottomNavigationBarButtonIndex = 1;

  @override
  String get appBarTitle => 'Викторина';

  @override
  List<AppBarAction> get appBarActions => [];
}

class _QuizScreenState extends State<QuizScreen> {
  int selectedButtonIndex = -1;
  int currentQuizItemIndex = 0;
  int correctlyAnsweredCount = 0;

  QuizItem get currentQuizItem => quizItems[currentQuizItemIndex];

  bool isSelectedAnswerCorrect = false;

  @override
  Widget build(BuildContext context) {
    assert(quizItems.isNotEmpty);

    final currentQuizItemCorrectAnswer = currentQuizItem.answers[currentQuizItem.correctAnswerIndex];
    final currentQuizItemShuffledAnswers = [...currentQuizItem.answers]
      ..shuffle(Random(randomSeed + currentQuizItemIndex));

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: Text(
                    'Вопрос ${currentQuizItemIndex + 1}/${quizItems.length}',
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              currentQuizItem.question,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 5 / 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              shrinkWrap: true,
              children: currentQuizItemShuffledAnswers
                  .select(
                    (e, i) => QuizAnswerButton(
                      title: e,
                      onTap: () {
                        setState(() {
                          selectedButtonIndex = i;
                          isSelectedAnswerCorrect = e == currentQuizItemCorrectAnswer;
                        });
                      },
                      chosen: i == selectedButtonIndex,
                    ),
                  )
                  .toList(),
            ),
          ),
          if (currentQuizItemIndex < quizItems.length - 1)
            MyFilledButton(
              title: 'Продолжить',
              enabled: selectedButtonIndex >= 0,
              onClick: () {
                setState(() {
                  if (isSelectedAnswerCorrect) {
                    correctlyAnsweredCount++;
                  }

                  selectedButtonIndex = -1;
                  isSelectedAnswerCorrect = false;
                  currentQuizItemIndex++;
                });
              },
            ),
          if (currentQuizItemIndex == quizItems.length - 1)
            MyFilledButton(
              title: 'Завершить викторину',
              enabled: selectedButtonIndex >= 0,
              onClick: () {
                setState(() {
                  if (isSelectedAnswerCorrect) {
                    correctlyAnsweredCount++;
                  }

                  changeScreen(QuizFinalScreen(correctlyAnsweredQuestionCount: correctlyAnsweredCount));
                });
              },
            ),
        ],
      ),
    );
  }
}
