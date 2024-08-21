import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final String error;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  const CustomTextField({super.key, required this.hint, required this.error, required this.onChanged, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        errorText: error,
        focusedBorder: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        errorBorder: buildOutlineInputBorder(),
        disabledBorder: buildOutlineInputBorder(),
        focusedErrorBorder: buildOutlineInputBorder(),
        border: buildOutlineInputBorder()
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(
              color: Colors.black
          )
      );
  }
}
