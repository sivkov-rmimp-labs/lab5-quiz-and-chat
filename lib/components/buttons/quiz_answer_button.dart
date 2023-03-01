import 'package:flutter/material.dart';
import 'package:lab5_quiz_and_chat/extensions.dart';

class QuizAnswerButton extends StatefulWidget {
  final String title;
  final bool chosen;
  final void Function()? onTap;

  const QuizAnswerButton({Key? key, required this.title, required this.chosen, this.onTap}) : super(key: key);

  @override
  State<QuizAnswerButton> createState() => _QuizAnswerButtonState();
}

class _QuizAnswerButtonState extends State<QuizAnswerButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          shape: widget.chosen
              ? RoundedRectangleBorder(
                  side: const BorderSide(color: Color.fromRGBO(87, 141, 52, 1), width: 3),
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
        if (widget.chosen)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(87, 141, 52, 1),
                borderRadius: BorderRadius.only(
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
