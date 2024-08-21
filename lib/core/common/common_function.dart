import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_task_app/core/constant/app_colors.dart';

class CommonFunction{

  static bool isEmailValidate(String em) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  static bool checkPanNo(String panNo){
    final regex = RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}");
    if (regex.hasMatch(panNo)) {
      return true;
    } else {
      return false;
    }
  }

  static bool checkGstNO(String gstNO){
    final regex = RegExp(r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$");
    if (regex.hasMatch(gstNO)) {
      return true;
    } else {
      return false;
    }
  }

  static Widget backPress({required BuildContext context}){
    return IconButton(
      icon: const Icon(CupertinoIcons.left_chevron),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  /*static dialog({
    required BuildContext context,required String title,required String subtitle, VoidCallback? onTapYes, VoidCallback? onTapNo,
  }){
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColor.appColor.withOpacity(0.2))
              ),
              onPressed: onTapYes,
              child: const Text("Yes",style: TextStyle(color: AppColor.appColor)),
            ),
            TextButton(
              style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(AppColor.appColor)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No",style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }*/


  static showSnackBar({required BuildContext context,required bool isError,required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message,style: const TextStyle(color: AppColors.whiteColor),),
          backgroundColor: isError ? Colors.red : Colors.green,
          duration: const Duration(seconds: 2),
        )
    );
  }
}