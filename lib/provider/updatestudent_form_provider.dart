import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/models/studentmodel.dart';
import 'package:p_student_management/widgets/popupdialogues.dart';

class EditStudentProvider extends ChangeNotifier {
  int _currentStep = 0;
  File? _imageFile;
  final _imagePicker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late Studentmodel _initialStudent;
  bool _imageChanged = false;

  final _nameController = TextEditingController();
  final _rollNumberController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _placeController = TextEditingController();
  DateTime? _dateOfBirth;

  int get currntStep => _currentStep;
  File? get imageFile => _imageFile;
  GlobalKey<FormState> get formkey => _formKey;
  TextEditingController get nameController => _nameController;
  TextEditingController get rollNumberController => _rollNumberController;
  TextEditingController get phoneNumberController => _phonenumberController;
  TextEditingController get emailController => _emailController;
  TextEditingController get placeController => _placeController;
  DateTime? get dateOfBirth => _dateOfBirth;
  Studentmodel get initialStudent => _initialStudent;
  bool get imageChanged => _imageChanged;

  void initialzeWithStudent(Studentmodel student) {
    _initialStudent = student;
    _nameController.text = student.name;
    _rollNumberController.text = student.rollNumber;
    _phonenumberController.text = student.phonNumber;
    _emailController.text = student.email;
    _placeController.text = student.place;
    _imageFile = student.imageFile;
    _imageChanged = false;

    if (student.dob != null && student.dob!.isNotEmpty) {
      try {
        _dateOfBirth = DateFormat('dd-MM-yyyy').parse(student.dob!);
      } catch (e) {
        try {
          _dateOfBirth = DateFormat('dd-MM-yyyy').parse(student.dob!);
        } catch (e) {
          _dateOfBirth = null;
        }
      }
    }
    notifyListeners();
  }

  void nextStep() {
    if (_currentStep < 1) {
      _currentStep++;
    }
    notifyListeners();
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
    }
    notifyListeners();
  }

  Future<void> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _imageChanged = true;
      notifyListeners();
    }
  }

  void setDateOfBirth(DateTime date) {
    _dateOfBirth = date;
    notifyListeners();
  }

  bool validateAndUpdateStudent(BuildContext context,
      Function(Studentmodel, Studentmodel) updateStudents) {
    if (!_formKey.currentState!.validate()) {
      return false;
    }

    if (_nameController.text.isEmpty ||
        _rollNumberController.text.isEmpty ||
        _phonenumberController.text.isEmpty) {
      customSnackBar(context, '"Please Fill in all required fields"', red);
      return false;
    }
    final updateStudent = Studentmodel(
        name: _nameController.text,
        imageFile: _imageFile,
        rollNumber: _rollNumberController.text,
        phonNumber: _phonenumberController.text,
        email: _emailController.text,
        place: _placeController.text,
        dob: _dateOfBirth != null
            ? DateFormat('dd-MM-yyyy').format(_dateOfBirth!)
            : '');

    updateStudents(_initialStudent, updateStudent);
    return true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _rollNumberController.dispose();
    _phonenumberController.dispose();
    _emailController.dispose();
    _placeController.dispose();
    super.dispose();
  }
}



