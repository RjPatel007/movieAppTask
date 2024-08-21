import 'package:flutter/material.dart';
import 'package:movie_task_app/core/constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final void Function() onTap;
  final double? width;
  const CustomButton({super.key, required this.buttonName, required this.onTap, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: AppColors.blueColor,
        ),
        child: Center(
            child: Text(buttonName,
              style: const TextStyle(
                fontSize: 20,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w500
              ),
            )
        ),
      ),
    );
  }
}
