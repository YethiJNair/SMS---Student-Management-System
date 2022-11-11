import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/screens/view_students.dart';
import 'package:main_project_hive/widgets/button_rounded.dart';
import 'package:main_project_hive/widgets/profile_picture.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class EditStudent extends StatefulWidget {
  final Student student;
  final Box<Student> studentBox;
  const EditStudent({Key? key, required this.student, required this.studentBox})
      : super(key: key);

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _emailController;
  TextEditingController? _phoneController;

  String? imagePath;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.student.name);
    _ageController = TextEditingController(text: widget.student.age);
    _emailController = TextEditingController(text: widget.student.email);
    _phoneController = TextEditingController(text: widget.student.phone);
    imagePath = widget.student.image;
    super.initState();
  }

  Future<void> updatePhoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      imagePath = image.path;
    });
  }

  Future<void> editStudent() async {
    final name = _nameController!.text;
    final age = _ageController!.text;
    final email = _emailController!.text;
    final phone = _phoneController!.text;
    if (name.isEmpty || age.isEmpty || email.isEmpty || phone.isEmpty) {
      return;
    }
    final _student = Student(
        name: name, age: age, email: email, phone: phone, image: imagePath!);
    await widget.studentBox.put(widget.student.key, _student);

    showEditedAlertBox(context);
  }

  void showEditedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Column(
              children: const [Text("Student Edited"), Divider()],
            ),
            content: const Text("Student edited successfully to the database"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      ctx,
                      MaterialPageRoute(builder: (ctx) => const ViewStudents()),
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
        title: const Text("Edit Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 50),
              ProfilePicture(
                imagePath: imagePath!,
                onPressed: () {
                  updatePhoto();
                },
              ),
              const SizedBox(height: 30),
              TextInputField(
                icon: Icons.person,
                hintText: 'Name',
                controller: _nameController!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The Name field is empty";
                  }
                  return null;
                },
              ),
              TextInputField(
                icon: Icons.numbers,
                hintText: 'Age',
                controller: _ageController!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The Age field is empty";
                  }
                  return null;
                },
              ),
              TextInputField(
                icon: Icons.email,
                hintText: 'Email',
                controller: _emailController!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The Email field is empty";
                  }
                  return null;
                },
              ),
              TextInputField(
                icon: Icons.phone,
                hintText: 'Phone',
                controller: _phoneController!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "The Phone field is empty";
                  }
                  return null;
                },
              ),
              ButtonRounded(
                buttonText: "Edit Student",
                onpress: () {
                  if (_formKey.currentState!.validate()) {
                    editStudent();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
