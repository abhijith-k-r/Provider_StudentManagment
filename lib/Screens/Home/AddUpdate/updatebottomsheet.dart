// ignore_for_file: recursive_getters
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/provider/updatestudent_form_provider.dart';
import 'package:p_student_management/widgets/popupdialogues.dart';
import 'package:provider/provider.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/models/studentmodel.dart';
import 'package:p_student_management/provider/provider.dart';
import 'package:p_student_management/widgets/bottomsheetwidget.dart';

class EditStudentBottomSheet extends StatelessWidget {
  final Studentmodel student;

  const EditStudentBottomSheet({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = EditStudentProvider();
        provider.initialzeWithStudent(student);
        return provider;
      },
      child: const _EditStudentBottomSheetContent(),
    );
  }
}

class _EditStudentBottomSheetContent extends StatelessWidget {
  const _EditStudentBottomSheetContent();

  Studentmodel get student => student;

  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<EditStudentProvider>(context);
    final studentsProvider =
        Provider.of<StudentsListProvider>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(
        color: white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          // !Handle bar
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          //! Progress indicators
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                2,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: formProvider.currntStep >= index ? red : grey[300],
                  ),
                ),
              ),
            ),
          ),

          //! Title with edit and delete options
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formProvider.currntStep == 0
                      ? "Edit Student"
                      : "Edit Additional Details",
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Step ${formProvider.currntStep + 1}/2",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: grey[600],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          //! Form content
          Expanded(
            child: Form(
              key: formProvider.formkey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: formProvider.currntStep == 0
                    ? buildStep1(
                        formProvider.pickImage,
                        formProvider.imageFile,
                        formProvider.nameController,
                        formProvider.rollNumberController,
                        formProvider.phoneNumberController,
                      )
                    : buildStep2(
                        context,
                        formProvider.dateOfBirth,
                        formProvider.emailController,
                        formProvider.placeController,
                        (pickedDate) {
                          formProvider.setDateOfBirth(pickedDate);
                        },
                      ),
              ),
            ),
          ),

          //! Navigation buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: formProvider.currntStep == 0
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (formProvider.currntStep > 0)
                  OutlinedButton(
                    onPressed: () {
                      formProvider.previousStep();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Back",
                      style: GoogleFonts.roboto(
                        color: grey[700],
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {
                    if (formProvider.currntStep < 1) {
                      formProvider.nextStep();
                    } else {
                      if (formProvider.validateAndUpdateStudent(
                        context,
                        (oldStudent, updatedStudent) => studentsProvider
                            .updateStudents(oldStudent, updatedStudent),
                      )) {
                        customSnackBar(
                            context, 'Student updated successfully', green);
                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    formProvider.currntStep < 1 ? "Next" : "Save Changes",
                    style: GoogleFonts.roboto(
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
