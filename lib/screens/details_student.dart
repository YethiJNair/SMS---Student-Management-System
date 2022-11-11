import 'dart:io';
import 'package:flutter/material.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/widgets/details.dart';

class DetailsStudent extends StatelessWidget {
  const DetailsStudent({Key? key, required this.student}) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 236, 230),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 47, 132, 158),
        title: const Text("Student Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              Center(
                child: CircleAvatar(
                  backgroundImage: FileImage(File(student.image)),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 30),
              Details(
                labeltext: 'Name : ${student.name}',
              ),
              Details(
                labeltext: 'Age : ${student.age}',
              ),
              Details(
                labeltext: 'Email : ${student.email}',
              ),
              Details(
                labeltext: 'Ph : ${student.phone}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
