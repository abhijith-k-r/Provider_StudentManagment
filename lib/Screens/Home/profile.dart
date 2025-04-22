import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/models/studentmodel.dart';
import 'package:p_student_management/provider/provider.dart';
import 'package:p_student_management/widgets/customappbar.dart';
import 'package:p_student_management/widgets/popupdialogues.dart';
import 'package:p_student_management/widgets/profilewidget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final Studentmodel student;
  const ProfileScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Consumer<StudentsListProvider>(builder: (context, value, child) {
      return Scaffold(
          backgroundColor: white,
          appBar: CustomeAppBar(
            title: Column(
              children: [
                Text("Student Details",
                    style: GoogleFonts.roboto(
                        fontSize: 22, fontWeight: FontWeight.w500)),
                Text("Active",
                    style: GoogleFonts.roboto(
                        fontSize: 12, fontWeight: FontWeight.w400))
              ],
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: red,
                  size: 22,
                )),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    showEditBottomSheet(context, student);
                  },
                  icon: Icon(
                    Icons.edit,
                    color: red,
                  )),
              //! PopupMenuButton for "More"
              PopupMenuButton(
                icon: Icon(Icons.more_vert_rounded, color: red),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onSelected: (value) {
                  if (value == 1) {
                    showDeleteConfirmation(context, student);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: red),
                        const SizedBox(width: 8),
                        Text('Delete',
                            style: GoogleFonts.roboto(
                              color: red,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            backgroundColor: white,
            shadowColor: grey,
            elevation: 0,
          ),
          body:
              Consumer<StudentsListProvider>(builder: (context, value, child) {
            final currentStudent = value.studdents.firstWhere(
                (s) => s.rollNumber == student.rollNumber,
                orElse: () => student);
            return SingleChildScrollView(
                child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  color: grey[200]!,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text("OverView",
                        style: GoogleFonts.roboto(
                            fontSize: 15, fontWeight: FontWeight.w300)),
                  ),
                ),
                Card(
                  color: white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildInfoRow('Student Name:', currentStudent.name,
                          size: 25),
                      buildInfoRow('RollNumber:', currentStudent.rollNumber,
                          size: 18),
                      buildPhotoRow(currentStudent),
                      buildInfoRow('Email:', currentStudent.email,
                          color: red, size: 17),
                      buildInfoRow('D.O.B:', currentStudent.dob.toString(),
                          size: 18),
                      buildInfoRow('Phone No:', currentStudent.phonNumber,
                          size: 18),
                      buildInfoRow('Place:', currentStudent.place, size: 18),
                    ],
                  ),
                )
              ],
            ));
          }));
    });
  }
}
