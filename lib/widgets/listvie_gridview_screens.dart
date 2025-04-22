// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/Screens/Home/profile.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/provider/provider.dart';
import 'package:p_student_management/widgets/popupdialogues.dart';

// ! ListView Screen Extracted
class ListviewScreeen extends StatelessWidget {
  StudentsListProvider value;

  ListviewScreeen({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                        fontSize: 14, fontWeight: FontWeight.w500, color: red)),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ! GreidView Screen Extracted
class GridviewScreen extends StatelessWidget {
  StudentsListProvider value;
  GridviewScreen({super.key, required this.value});

  @override
  Widget build(
    BuildContext context,
  ) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: 160,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                          image: DecorationImage(
                              image: student.imageFile != null
                                  ? FileImage(student.imageFile!)
                                  : AssetImage('assets/studet_avatar.avif'),
                              fit: BoxFit.cover)),
                    ),
                    Text(student.name,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 20,
                        )),
                    Text(student.email,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: red,
                        )),
                  ],
                )),
          ),
        );
      },
    );
  }
}
