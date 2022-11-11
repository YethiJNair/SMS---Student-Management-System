import 'dart:io';

import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  ProfilePicture({super.key, required this.imagePath, required this.onPressed});
  final String imagePath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            backgroundImage: (imagePath != null)
                ? FileImage(File(imagePath))
                : const AssetImage("assets/image/avatar.jpeg") as ImageProvider,
            radius: 60,
          ),
        ),
        Positioned(
          top: 65,
          left: 210,
          child: Container(
            height: 40,
            width: 50,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(173, 194, 169, 1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.arrow_upward_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}