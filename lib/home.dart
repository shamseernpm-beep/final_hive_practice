import 'package:dummy_6/model/student_model.dart';
import 'package:dummy_6/service/student_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  final String username;
  const Home({super.key, required this.username});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Box<StudentModel> studentbox = Hive.box<StudentModel>("List");
  final service = StudentService();
  int? editIndex;

  final usernameController = TextEditingController();
  final ageController = TextEditingController();

  void press() async {
    String username = usernameController.text;
    int age = int.tryParse(ageController.text) ?? 0;

    if (username.isEmpty || age.toString().isEmpty) {
      return;
    }

    StudentModel studentModel = StudentModel(username: username, age: age);

    if (editIndex == null) {
      await service.addData(studentModel);
    } else {
      await service.update(editIndex!, studentModel);
    }

    usernameController.clear();
    ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.blue,
        title: Text(widget.username),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "enter your name ",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                hintText: "enter your age",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 40,

              child: ElevatedButton(
                onPressed: () {
                  press();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text("SAVE"),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentbox.listenable(),
                builder: (context, box, child) {
                  final students = service.valueList();
                  return ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          title: Text(student.username),
                          subtitle: Text(student.age.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  usernameController.text =
                                      students[index].username;
                                  ageController.text = students[index].age
                                      .toString();
                                  editIndex = index;
                                },
                                icon: Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await service.delete(index);
                                },
                                icon: Icon(Icons.delete, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
