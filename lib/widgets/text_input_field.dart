import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final void Function(String)? onChanged;
  final String? Function(String?) validator;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Color.fromARGB(255, 44, 44, 44)),
          hintText: hintText,
          filled: true,
          fillColor: const Color.fromARGB(255, 235, 233, 233),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
        ),
        validator: validator,
      ),
    );
  }
}