import 'package:flutter/material.dart';
import 'package:p_student_management/models/studentmodel.dart';

class StudentsListProvider extends ChangeNotifier {
  final List<Studentmodel> _students = [];
  List<Studentmodel> _filteredStudents = [];
  List<Studentmodel> get studdents =>
      _filteredStudents.isNotEmpty ? _filteredStudents : _students;

  bool _isGridView = false;
  bool get isGreidView => _isGridView;

  void toggleView() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

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

  void searchStudents(String query) {
    if (query.isEmpty) {
      _filteredStudents = [];
    } else {
      _filteredStudents = _students.where((student) {
        return student.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _filteredStudents = [];
    notifyListeners();
  }
}
