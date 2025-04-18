import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:p_student_management/models/studentmodel.dart';

class AddstudentFormProvider extends ChangeNotifier {
  int _currentStep = 0;
  File? _imageFile;
  final _imagePicker = ImagePicker();
  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _rollNumberController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _placeController = TextEditingController();
  DateTime? _dateOfBirth;

  int get currentStep => _currentStep;
  File? get imageFile => _imageFile;
  GlobalKey<FormState> get formkey => _formkey;
  TextEditingController get nameController => _nameController;
  TextEditingController get rollNumberController => _rollNumberController;
  TextEditingController get phonenumberController => _phonenumberController;
  TextEditingController get emailController => _emailController;
  TextEditingController get placeController => _placeController;
  DateTime? get dateOfBirth => _dateOfBirth;

  void nextstep() {
    if (_currentStep < 1) {
      _currentStep++;
      notifyListeners();
    }
  }

  void previousStep() {
    if (_currentStep > 0) {
      _currentStep--;
      notifyListeners();
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  void setDateOfBirth(DateTime date) {
    _dateOfBirth = date;
    notifyListeners();
  }

  bool validateAndSaveStudent(
      BuildContext context, Function(Studentmodel) addStudent) {
    if (!formkey.currentState!.validate()) {
      return false;
    }

    if (_nameController.text.isEmpty ||
        _rollNumberController.text.isEmpty ||
        _phonenumberController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _placeController.text.isEmpty ||
        _dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return false;
    }

    final student = Studentmodel(
      name: _nameController.text,
      imageFile: _imageFile,
      rollNumber: _rollNumberController.text,
      email: _emailController.text,
      phonNumber: _phonenumberController.text,
      dob: DateFormat('dd-MM-yyyy').format(_dateOfBirth!),
      place: _placeController.text,
    );

    addStudent(student);
    resetForm();
    return true;
  }

  void resetForm() {
    _currentStep = 0;
    _imageFile = null;
    _dateOfBirth = null;
    _nameController.clear();
    _rollNumberController.clear();
    _phonenumberController.clear();
    _emailController.clear();
    _placeController.clear();
    notifyListeners();
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
