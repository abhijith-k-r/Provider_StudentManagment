// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/Screens/Home/profile.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/provider/provider.dart';
import 'package:p_student_management/widgets/popupdialogues.dart';
import 'package:p_student_management/widgets/customappbar.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        title: Text("Student List",
            style:
                GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w500)),
        centerTitle: true,
        backgroundColor: white,
        shadowColor: grey,
        elevation: 1,
      ),
      body: Consumer<StudentsListProvider>(builder: (context, value, child) {
        return value.studdents.isEmpty
            ? Center(
                child: Text('No students added yet.',
                    style: GoogleFonts.roboto(
                        fontSize: 20, color: red, fontWeight: FontWeight.w300)),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: value.studdents.length,
                          itemBuilder: (context, index) {
                            final student = value.studdents[index];
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: CircleAvatar(
                                backgroundColor: red,
                                radius: 35,
                                backgroundImage: student.imageFile != null
                                    ? FileImage(student.imageFile!)
                                    : null,
                                child: student.imageFile == null
                                    ? Icon(
                                        Icons.person,
                                        size: 35,
                                      )
                                    : null,
                              ),
                            );
                          }),
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: value.studdents.length,
                      itemBuilder: (context, index) {
                        final student = value.studdents[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: Card(
                            color: white,
                            child: InkWell(
                              onLongPress: () {
                                showDeleteConfirmation(context, student);
                              },
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ProfileScreen(
                                            student: student,
                                          ))),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 35,
                                  backgroundColor: red,
                                  backgroundImage: student.imageFile != null
                                      ? FileImage(student.imageFile!)
                                      : null,
                                  child: student.imageFile == null
                                      ? Icon(
                                          Icons.person,
                                          size: 35,
                                        )
                                      : null,
                                ),
                                title: Text(student.name,
                                    style: GoogleFonts.roboto(
                                      fontSize: 20,
                                    )),
                                subtitle: Text(student.email,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: red)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 30, 60),
        child: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            showAddStudentBottomSheet(context);
          },
          backgroundColor: white,
          child: Icon(Icons.add, color: red),
        ),
      ),
    );
  }
}
