import 'dart:io';

class Studentmodel {
  final String name;
  final File? imageFile;
  final String rollNumber;
  final String phonNumber;
  final String email;
  final String? dob;
  final String place;

  Studentmodel({
    required this.name,
    this.imageFile,
    required this.rollNumber,
    required this.phonNumber,
    required this.email,
    this.dob,
    required this.place,
  });
}
