import 'package:flutter/material.dart';

class ButtonRounded extends StatelessWidget {
  const ButtonRounded(
      {super.key, required this.buttonText, required this.onpress});

  final String buttonText;
  final void Function() onpress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 47, 132, 158),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
