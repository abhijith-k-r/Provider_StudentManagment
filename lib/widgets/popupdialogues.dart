import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/Screens/Home/AddUpdate/addbottomsheet.dart';
import 'package:p_student_management/Screens/Home/AddUpdate/updatebottomsheet.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/models/studentmodel.dart';
import 'package:p_student_management/provider/provider.dart';
import 'package:provider/provider.dart';

// ! Showing Adding Screen
void showAddStudentBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext sheetContext) =>
          Builder(builder: (innerContext) => AddStudentBottomSheet()));
}

// ! Show Edit Bottom Screen
void showEditBottomSheet(BuildContext context, Studentmodel student) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => EditStudentBottomSheet(student: student),
  );
}

//! Delete confirmation dialog
void showDeleteConfirmation(BuildContext context, Studentmodel student) {
  final provider = Provider.of<StudentsListProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Delete Student?',
        style: GoogleFonts.roboto(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Are you sure you want to delete ${student.name}? This action cannot be undone.',
        style: GoogleFonts.roboto(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: GoogleFonts.roboto(
              color: grey[700],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            provider.deleteStudent(student);

            Navigator.pop(context);
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            customSnackBar(context, 'Student deleted successfully', red);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: red,
          ),
          child: Text(
            'Delete',
            style: GoogleFonts.roboto(
              color: white,
            ),
          ),
        ),
      ],
    ),
  );
}

// !Custom SnackBar...
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    BuildContext context, String text, Color? color) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      textAlign: TextAlign.center,
      text,
      style: GoogleFonts.roboto(
        fontSize: 15,
        color: color,
      ),
    ),
    backgroundColor: white,
    duration: Duration(seconds: 2),
  ));
}
