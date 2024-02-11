import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final void Function()? onpressed;
  final String text;
  const MyBtn({super.key, required this.onpressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      onPressed: onpressed,
      child: Text(text),
    );
  }
}
