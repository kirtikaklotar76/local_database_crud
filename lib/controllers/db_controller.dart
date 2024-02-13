import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:local_crud_demo/helpers/db_helper.dart';
import 'package:local_crud_demo/modals/student_modal.dart';

class DbController extends GetxController {
  RxList<Student> allStudents = <Student>[].obs;

  DbController() {
    DbHelper.dbHelper.initDb();
  }

  Future<void> init() async {
    allStudents(await DbHelper.dbHelper.getData());
  }

  Future<void> addStudent({required Student student}) async {
    await DbHelper.dbHelper.insert(student: student).then(
          (value) => init(),
        );
  }

  Future<void> deleteStudent({required Student student}) async {
    await DbHelper.dbHelper.delete(student: student).then(
          (value) => init(),
        );
  }

  Future<void> updateStudent({required Student student}) async {
    await DbHelper.dbHelper.update(student: student).then(
          (value) => init(),
        );
  }
}
