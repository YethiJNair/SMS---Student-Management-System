import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/screens/add_students.dart';
import 'package:main_project_hive/screens/details_student.dart';
import 'package:main_project_hive/screens/edit_student.dart';
import 'package:main_project_hive/screens/search_screen.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({Key? key}) : super(key: key);

  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  Box<Student>? studentBox;

  @override
  void initState() {
    studentBox = Hive.box<Student>('Student');
    super.initState();
  }

  void showDeletedAlertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: Column(
              children: const [
                Text("Student Deleted"),
                Divider(),
              ],
            ),
            content:
                const Text("Student deleted successfully from the database"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  Future<void> deleteStudent(Box<Student> studenstList, Student student) async {
    await studenstList.delete(student.key);
    showDeletedAlertBox(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 245, 237, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 132, 158),
        title: const Text("View Students"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SearchScreen()));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            listAllStudent(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 47, 132, 158),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AddStudent(studentBox: studentBox!),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget listAllStudent() {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: studentBox!.listenable(),
        builder:
            (BuildContext context, Box<Student> studenstList, Widget? child) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: studenstList.length,
            itemBuilder: (context, index) {
              final key = studenstList.keys.toList()[index];
              final student = studenstList.get(key);
              File imageFile = File(student!.image);
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (conntext) => DetailsStudent(student: student),
                    ),
                  );
                },
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: FileImage(imageFile),
                ),
                title: Text(student.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditStudent(
                              student: student,
                              studentBox: studentBox!,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 94, 94, 94),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteStudent(studenstList, student);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 175, 79, 49),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
