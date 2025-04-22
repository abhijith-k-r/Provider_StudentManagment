// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:p_student_management/colors/appcolors.dart';

// ! First textfields&CircleAvatar..
Widget buildStep1(
    VoidCallback pickImage,
    File? imageFile,
    TextEditingController nameController,
    TextEditingController rollNumberController,
    TextEditingController phonenumberController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //! Photo picker
      Center(
        child: GestureDetector(
          onTap: pickImage,
          child: Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: grey[200],
                  shape: BoxShape.circle,
                  image: imageFile != null
                      ? DecorationImage(
                          image: FileImage(imageFile),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: imageFile == null
                    ? Icon(
                        Icons.person,
                        size: 50,
                        color: grey,
                      )
                    : null,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      const SizedBox(height: 25),

      //! Full Name
      buildTextField(
        label: "Full Name",
        hint: "Enter student name",
        controller: nameController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter student name";
          }
          return null;
        },
      ),

      const SizedBox(height: 15),

      //! Roll Number
      buildTextField(
        label: "Roll Number",
        hint: "Enter roll number",
        controller: rollNumberController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter roll number";
          }
          return null;
        },
      ),

      const SizedBox(height: 15),

      //! Admission Number
      buildTextField(
        label: "Phone Number",
        hint: "Enter Phone number",
        controller: phonenumberController,
        keyboardType: TextInputType.phone,
        maxLength: 10,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter phone number';
          } else if (value.length != 10) {
            return 'Phone number must be exactly 10 digits';
          }
          return null;
        },
      ),
    ],
  );
}

// ! Custome_TextField
Widget buildTextField({
  required String label,
  required String hint,
  required TextEditingController controller,
  TextInputType keyboardType = TextInputType.text,
  int? maxLength,
  String? Function(String?)? validator,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.roboto(
          fontSize: 14,
          color: grey[700],
        ),
      ),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.roboto(
            color: grey[400],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: red),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: red),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        ),
      ),
    ],
  );
}

// ! Second_Components....

Widget buildStep2(
    BuildContext context,
    DateTime? dateOfBirth,
    TextEditingController emailController,
    TextEditingController placeControlleer,
    Function(DateTime) onDateOfBirthChanged) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //! Email
      buildTextField(
        label: "Email",
        hint: "Enter email address",
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value != null && value.isNotEmpty) {
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return "Please enter a valid email address";
            }
          }
          return null;
        },
      ),

      const SizedBox(height: 15),

      //! Date of Birth
      buildDateField(
        label: "Date of Birth",
        hint: dateOfBirth != null
            ? DateFormat('dd-MMM-yyyy').format(dateOfBirth)
            : "Select date of birth",
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: red,
                  ),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            onDateOfBirthChanged(picked);
          }
        },
      ),

      const SizedBox(height: 15),

      buildTextField(
        label: "Place",
        hint: "Enter Place",
        controller: placeControlleer,
      ),

      const SizedBox(height: 15),
    ],
  );
}

// !DateFiled inside the secondComponets..

Widget buildDateField({
  required String label,
  required String hint,
  required VoidCallback onTap,
  DateTime? dateOfBirth,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.roboto(
          fontSize: 14,
          color: grey[700],
        ),
      ),
      const SizedBox(height: 6),
      InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                hint,
                style: GoogleFonts.roboto(
                  color: dateOfBirth != null ? black : grey[400],
                ),
              ),
              Icon(
                Icons.calendar_today,
                size: 18,
                color: grey[600],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
