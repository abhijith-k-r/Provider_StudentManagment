import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/provider/provider.dart';
import 'package:p_student_management/widgets/customappbar.dart';
import 'package:p_student_management/widgets/listvie_gridview_screens.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return Scaffold(
        appBar: CustomeAppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new, color: red, size: 22)),
          centerTitle: true,
          title: Text('Search Students',
              style: GoogleFonts.roboto(
                  fontSize: 22, fontWeight: FontWeight.w500)),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    prefixIcon: const Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onChanged: (value) {
                    if (debounce?.isActive ?? false) debounce?.cancel();
                    debounce = Timer(Duration(milliseconds: 300), () {});
                    Provider.of<StudentsListProvider>(context, listen: false)
                        .searchStudents(value);
                  },
                ),
              ),
            ),
          ),
        ),
        body: Consumer<StudentsListProvider>(
          builder: (context, value, child) {
            return ListviewScreeen(value: value);
          },
        ));
  }
}
