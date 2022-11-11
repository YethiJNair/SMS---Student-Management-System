import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_project_hive/models/student_model.dart';
import 'package:main_project_hive/screens/details_student.dart';
import 'package:main_project_hive/screens/view_students.dart';
import 'package:main_project_hive/widgets/text_input_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  final List<Student> studentBoxList =
      Hive.box<Student>('Student').values.toList();

  late List<Student> displayStudent = List<Student>.from(studentBoxList);

  void searchStudentList(String value) {
    setState(() {
      displayStudent = studentBoxList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(254, 245, 237, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 47, 132, 158),
        title: const Text("Search Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            TextInputField(
              validator: (value) {
                return;
              },
              icon: Icons.search,
              hintText: "Search Names",
              controller: _searchController,
              onChanged: (value) {
                searchStudentList(value);
              },
            ),
            Expanded(
              child: (displayStudent.length != 0)
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        File imageFile = File(displayStudent[index].image);
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(imageFile),
                            radius: 40,
                          ),
                          onTap: () async{
                            goto(index);
                          },
                          title: Text(displayStudent[index].name),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: displayStudent.length,
                    )
                  : const Center(child: Text("The data is not Found")),
            ),
          ],
        ),
      ),
    );
  }

  goto(int index) async {
    final studentBox = await Hive.openBox<Student>('Student');

    final stud = studentBox.getAt(index);
    if (stud == null) {
      return const Text('null');
    }
    return Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> DetailsStudent(student: stud)))
    ;
  }
}
