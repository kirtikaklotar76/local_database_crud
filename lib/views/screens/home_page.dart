import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_crud_demo/controllers/db_controller.dart';
import 'package:local_crud_demo/modals/student_modal.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    DbController dbController = Get.find<DbController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
              () =>
              ListView.builder(
                itemCount: dbController.allStudents.length,
                itemBuilder: (context, index) {
                  Student student = dbController.allStudents[index];

                  return Card(
                    child: ExpansionTile(
                      title: Text(student.name),
                      subtitle: Text(student.course),
                      trailing: Text(student.age.toString()),

                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) =>
                                      AlertDialog(
                                        title: const Text("Edit Student"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            TextFormField(
                                              initialValue: student.name,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (val) =>
                                              student.name = val,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              initialValue: student.course,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (val) =>
                                              student.course = val,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            TextFormField(
                                              initialValue: student.age
                                                  .toString(),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (val) =>
                                              student.age = int.parse(val),
                                            ),
                                          ],
                                        ),
                                        actions: [
                                          OutlinedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              dbController
                                                  .updateStudent(
                                                  student: student)
                                                  .then(
                                                    (value) =>
                                                    Navigator.pop(context),
                                              );
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              child: const Text("Update"),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                dbController.deleteStudent(student: student);
                              },
                              child: const Text("Delete"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Student student = Student(1, "Kirti", "Flutter", 23);

          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: const Text("Add Student"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        onChanged: (value) => student.name = value,
                        decoration: InputDecoration(
                          hintText: "Enter student name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (value) => student.course = value,
                        decoration: InputDecoration(
                          hintText: "Enter Course ",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onChanged: (value) => student.age = int.parse(value),
                        decoration: InputDecoration(
                          hintText: "Enter student age",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Cancel"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        dbController
                            .addStudent(student: student)
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
