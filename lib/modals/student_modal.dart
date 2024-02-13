import 'package:flutter/material.dart';

class Student {
  int id;
  String name;
  String course;
  int age;

  Student(this.id, this.name, this.course, this.age);

  factory Student.fromMap({required Map data}) => Student(
        data['id'],
        data['name'],
        data['course'],
        data['age'],
      );

  Map<String, dynamic> get toMap => {
        'id': id,
        'name': name,
        'course': course,
        'age': age,
      };
}
