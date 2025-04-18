import 'package:flutter/material.dart';
import 'package:p_student_management/models/studentmodel.dart';

class StudentsListProvider extends ChangeNotifier {
  final List<Studentmodel> _students = [];
  List<Studentmodel> get studdents => _students;

  void addStudent(Studentmodel student) {
    _students.add(student);
    notifyListeners();
  }

  void updateStudents(Studentmodel oldStudent, Studentmodel updatedStudent) {
    final index =
        _students.indexWhere((s) => s.rollNumber == oldStudent.rollNumber);

    if (index != -1) {
      _students[index] = updatedStudent;
      notifyListeners();
    }
  }

  void deleteStudent(Studentmodel student) {
    _students.removeWhere((s) => s.rollNumber == student.rollNumber);
    notifyListeners();
  }
}
