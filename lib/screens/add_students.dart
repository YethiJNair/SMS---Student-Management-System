import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/screens/view_students.dart';
import 'package:main_project_hive/widgets/button_rounded.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key? key, required this.studentBox}) : super(key: key);

  Box<Student> studentBox;

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // File? image;
  String? imagePath;

  Future<void> addPhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    // final imageFile = File(image.path);
    setState(() {
      // this.image = imageFile;
      this.imagePath = image.path;
    });
  }

  Future<void> addStudent(Box<Student> studentBox, BuildContext context) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final email = _emailController.text;
    final phone = _phoneController.text;
    if (age.isEmpty ||
        name.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        imagePath!.isEmpty) {
      return;
    }

    final student = Student(
        name: name, age: age, email: email, phone: phone, image: imagePath!);
    await studentBox.add(student);

    showAddedAlertBox(context);
  }

  void showAddedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Column(
              children: const [
                Text("Student Added"),
                Divider(),
              ],
            ),
            content: const Text("Student added successfully to the database"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      ctx,
                      MaterialPageRoute(
                          builder: (context) => const ViewStudents()),
                      (route) => false);
                  // Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 245, 237, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 132, 158),
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 50),
              profilePicture(),
              const SizedBox(height: 30),
              TextInputField(
                icon: Icons.person,
                hintText: "Name",
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The Name field is empty";
                  }
                  return null;
                },
              ),
              TextInputField(
                icon: Icons.numbers,
                hintText: "Age",
                controller: _ageController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The Age field is empty";
                  }
                  return null;
                },
              ),
              TextInputField(
                icon: Icons.email,
                hintText: "Email",
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The Email field is empty";
                  }
                  return null;
                },
              ),
              TextInputField(
                icon: Icons.phone,
                hintText: "Phone number",
                controller: _phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The Phone field is empty";
                  }
                  return null;
                },
              ),
              ButtonRounded(
                buttonText: "Add Student",
                onpress: () {
                  if (_formKey.currentState!.validate()) {
                    addStudent(widget.studentBox, context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profilePicture() {
    return Stack(
      children: [
        Center(
          child: CircleAvatar(
            backgroundImage: (imagePath != null)
                ? FileImage(File(imagePath!))
                : const AssetImage("assets/image/ava.jpeg") as ImageProvider,
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
              color: Color.fromARGB(255, 47, 132, 158),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                addPhoto();
              },
              icon: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
