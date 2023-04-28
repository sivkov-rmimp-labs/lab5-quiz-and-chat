import 'package:flutter/material.dart';
import 'package:lab5_quiz_and_chat/extensions.dart';

class QuizAnswerButton extends StatefulWidget {
  final String title;
  final bool isChosen;
  final bool isCorrect;
  final void Function()? onTap;

  const QuizAnswerButton({Key? key, required this.title, required this.isChosen, required this.isCorrect, this.onTap}) : super(key: key);

  static const correctColor = Color.fromRGBO(87, 141, 52, 1);
  static const incorrectColor = Color.fromRGBO(160, 21, 45, 1);
  Color get color => isCorrect ? correctColor : incorrectColor;


  @override
  State<QuizAnswerButton> createState() => _QuizAnswerButtonState();
}

class _QuizAnswerButtonState extends State<QuizAnswerButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          shape: widget.isChosen
              ? RoundedRectangleBorder(
                  side: BorderSide(color: widget.color, width: 3),
                  borderRadius: BorderRadius.circular(15),
                )
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
          color: Theme.of(context).scaffoldBackgroundColor.brighten(10),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(15),
            child: Center(child: Text(widget.title)),
          ),
        ),
        if (widget.isChosen)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Text('Ваш выбор'),
              ),
            ),
          ),
      ],
    );
  }
}
