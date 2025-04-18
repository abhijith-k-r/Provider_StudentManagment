import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:p_student_management/provider/addstudent_form_provider.dart';
import 'package:p_student_management/widgets/bottomsheetwidget.dart';
import 'package:p_student_management/widgets/popupdialogues.dart';
import 'package:provider/provider.dart';
import 'package:p_student_management/colors/appcolors.dart';
import 'package:p_student_management/provider/provider.dart';

class AddStudentBottomSheet extends StatelessWidget {
  const AddStudentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddstudentFormProvider(),
      child: _AddStudentBottomSheetContent(),
    );
  }
}

class _AddStudentBottomSheetContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<AddstudentFormProvider>(context);
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
          //! Handle bar
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
                    color: formProvider.currentStep >= index ? red : grey[300],
                  ),
                ),
              ),
            ),
          ),

          //! Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formProvider.currentStep == 0
                      ? "Add Student"
                      : "Additional Details",
                  style: GoogleFonts.roboto(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Step ${formProvider.currentStep + 1}/2",
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
                child: formProvider.currentStep == 0
                    ? buildStep1(
                        formProvider.pickImage,
                        formProvider.imageFile,
                        formProvider.nameController,
                        formProvider.rollNumberController,
                        formProvider.phonenumberController,
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
              mainAxisAlignment: formProvider.currentStep == 0
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.spaceBetween,
              children: [
                if (formProvider.currentStep > 0)
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
                    if (formProvider.currentStep < 1) {
                      formProvider.nextstep();
                    } else {
                      if (formProvider.validateAndSaveStudent(
                        context,
                        (student) => studentsProvider.addStudent(student),
                      )) {
                        Navigator.pop(context);
                        customSnackBar(context,
                            'successfully added student details', green);
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
                    formProvider.currentStep < 1 ? "Next" : "Save",
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
