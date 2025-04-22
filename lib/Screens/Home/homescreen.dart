// ignore_for_file: unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/Screens/search_screen.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/provider/provider.dart';
import 'package:p_student_management/widgets/listvie_gridview_screens.dart';
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
              style: GoogleFonts.roboto(
                  fontSize: 24, fontWeight: FontWeight.w500)),
          centerTitle: true,
          backgroundColor: white,
          shadowColor: grey,
          elevation: 1,
          actions: [
            Consumer<StudentsListProvider>(
              builder: (context, value, child) {
                return IconButton(
                    onPressed: () {
                      value.toggleView();
                    },
                    icon: value.isGreidView
                        ? Icon(Icons.grid_view_rounded)
                        : Icon(Icons.list));
              },
            )
          ],
        ),
        body: Consumer<StudentsListProvider>(builder: (context, value, child) {
          return value.studdents.isEmpty
              ? Center(
                  child: Text('No students added yet.',
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: red,
                          fontWeight: FontWeight.w300)),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: HorizontalListvieScreen(
                          value: value,
                        ),
                      ),
                      Consumer<StudentsListProvider>(
                          builder: (context, value, child) => value.isGreidView
                              ? GridviewScreen(value: value)
                              : ListviewScreeen(value: value))
                    ],
                  ),
                );
        }),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 25, 10),
              child: FloatingActionButton(
                heroTag: 'search-fab',
                mini: true,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (ctx) => SearchScreen()));
                },
                backgroundColor: red,
                child: Icon(
                  Icons.search,
                  color: white,
                ),
              ),
            ),
            Padding(
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
          ],
        ));
  }
}
