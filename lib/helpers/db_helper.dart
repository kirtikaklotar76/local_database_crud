import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_crud_demo/modals/student_modal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  DbHelper._();

  static final DbHelper dbHelper = DbHelper._();
  late Database database;

  String query = "";
  String studentTable = "Student";
  String colId = "id";
  String colName = "name";
  String colCourse = "course";
  String colAge = "age";

  Future<void> initDb() async {
    String dbPath = await getDatabasesPath();
    String dbName = "MyDatabase1.db";
    String finalPath = join(dbPath, dbName);

    database = await openDatabase(
      finalPath,
      version: 1,
      onCreate: (db, version) {
        query =
            "CREATE TABLE $studentTable($colId INTEGER PRIMARY KEY  AUTOINCREMENT,$colName TEXT,$colCourse TEXT,$colAge INTEGER)";

        db
            .execute(query)
            .then(
                (value) => log("$studentTable table created successfully!!!!"))
            .onError(
              (error, stackTrace) => log("Error : $error"),
            );
      },
    );
  }

  Future<void> insert({required Student student}) async {
    Map<String, dynamic> data = student.toMap;
    data.remove('id');

    await database
        .insert(studentTable, data)
        .then((value) => log("Student inserted successfully!!!"))
        .onError(
          (error, stackTrace) => log("Inserstion error : $error"),
        );
  }

  Future<List<Student>> getData() async {
    query = "SELECT * FROM $studentTable";

    List<Map> allData = await database.rawQuery(query);
    return allData.map((e) => Student.fromMap(data: e)).toList();
  }

  Future<void> delete({required Student student}) async {
    await database
        .delete(studentTable, where: "id = ${student.id}")
        .then((value) => log("Student deleted successfully!!!"))
        .onError(
          (error, stackTrace) => log("Error : $error"),
        );
  }

  Future<void> update({required Student student}) async {
    await database
        .update(studentTable, student.toMap, where: "id = ${student.id}")
        .then((value) => log("Student updated successfully!!!"))
        .onError(
          (error, stackTrace) => log("Error : $error"),
        );
  }
}
