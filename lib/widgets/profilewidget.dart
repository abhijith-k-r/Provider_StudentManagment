import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/models/studentmodel.dart';

// !Profile_Screen_Student_Details 
Widget buildInfoRow(String label, String value, {Color? color, double? size}) {
  return Container(
    color: white,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        SizedBox(
          width: 120,
          child: Text(label,
              style: GoogleFonts.roboto(
                  fontSize: 15, fontWeight: FontWeight.w600, color: grey[600])),
        ),
        Expanded(
          child: Text(value,
              style: GoogleFonts.roboto(
                fontSize: size,
                fontWeight: FontWeight.w400,
                color: color,
              )),
        ),
      ],
    ),
  );
}

// !Profile_Screen_Student_Phot
Widget buildPhotoRow(Studentmodel student) {
  return Container(
      color: white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 120,
          child: Text('Photo',
              style: GoogleFonts.roboto(
                  fontSize: 15, fontWeight: FontWeight.w400, color: grey[600])),
        ),
        Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: student.imageFile != null
                            ? FileImage(student.imageFile!) as ImageProvider
                            : AssetImage('assets/studet_avatar.avif'),
                        fit: BoxFit.cover)),
                child: student.imageFile == null
                    ? Icon(
                        Icons.person,
                        size: 35,
                      )
                    : null,
              )),
        ),
      ]));
}