import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_task_app/core/common/common_function.dart';
import 'package:movie_task_app/core/constant/app_colors.dart';
import 'package:movie_task_app/core/constant/navigator.dart';
import 'package:movie_task_app/view/widget/custom_button.dart';
import 'package:movie_task_app/view/widget/custom_text_field.dart';

import '../../../core/bloc/movie_bloc/movie_bloc.dart';
import '../../../core/models/model_movie.dart';

class AddMovieScreen extends StatefulWidget {
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  TextEditingController movieNameController = TextEditingController();
  TextEditingController movieDescriptionController = TextEditingController();

  bool movieNameValid = true;
  String movieNameError = "";

  bool movieNameValidation() {
    if (movieNameController.text.trim().isEmpty) {
      movieNameValid = false;
      movieNameError = "Please Enter Movie Name";
      setState(() {});
      return false;
    } else {
      movieNameValid = true;
      setState(() {});
      return true;
    }
  }

  bool movieDescriptionValid = true;
  String movieDescriptionError = "";

  bool movieDescriptionValidation() {
    if (movieDescriptionController.text.trim().isEmpty) {
      movieDescriptionValid = false;
      movieDescriptionError = "Please Enter Movie Description";
      setState(() {});
      return false;
    } else {
      movieDescriptionValid = true;
      setState(() {});
      return true;
    }
  }

  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        // print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            NextScreen.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Add Movie"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                _pickImage(ImageSource.gallery);
              },
              child: _imageFile != null
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(11),
                          child: Image.file(
                            _imageFile!,
                            height: 130,
                            width: 130,
                            fit: BoxFit.fill,
                          )),
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                          color: AppColors.blueColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(11)),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.whiteColor,
                      ),
                    ),
            ),
            CustomTextField(
              controller: movieNameController,
              hint: "Enter Movie Name",
              error: movieNameValid ? "" : movieNameError,
              onChanged: (value) {
                movieNameValidation();
              },
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              controller: movieDescriptionController,
              hint: "Enter Movie Description",
              error: movieDescriptionValid ? "" : movieDescriptionError,
              onChanged: (value) {
                movieDescriptionValidation();
              },
            ),
            CustomButton(
                key: const Key('submit_button'),
                buttonName: "Submit",
                onTap: () {
                  if (_imageFile != null) {
                    if (movieNameValidation() && movieDescriptionValidation()) {
                      BlocProvider.of<MovieBloc>(context).add(AddMovieEvent(
                          modelMovie: ModelMovie(
                              title: movieNameController.text.trim(),
                              description:
                                  movieDescriptionController.text.trim(),
                              imagePath: (_imageFile ?? File("")).path)));
                      CommonFunction.showSnackBar(
                          context: context,
                          isError: false,
                          message: "Movie Added Successfully");
                      NextScreen.pop(context);
                    }
                  } else {
                    CommonFunction.showSnackBar(
                        context: context,
                        isError: true,
                        message: "Please Upload Image");
                  }
                })
          ],
        ),
      ),
    );
  }
}
