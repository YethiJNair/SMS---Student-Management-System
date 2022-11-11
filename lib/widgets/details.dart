import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({
    Key? key,
    required this.labeltext,
  }) : super(key: key);

  final String labeltext;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(255, 235, 233, 233),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 15),
        child: Text(
          labeltext,
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey.shade700,
          ),
        ),
      ),
    );
  }
}