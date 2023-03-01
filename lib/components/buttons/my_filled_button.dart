import 'package:flutter/material.dart';

class MyFilledButton extends StatelessWidget {
  final String title;
  final void Function()? onClick;
  final void Function()? onClickWhenDisabled;
  final bool enabled;
  final bool clickableWhenDisabled;

  const MyFilledButton({
    Key? key,
    required this.title,
    this.onClick,
    this.onClickWhenDisabled,
    this.enabled = true,
    this.clickableWhenDisabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: enabled ? onClick : clickableWhenDisabled ? onClick : onClickWhenDisabled,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 72),
            child: Opacity(
              opacity: enabled ? 1 : 0.5,
              child: Text(
                title.toUpperCase(),
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
