import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task_app/core/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_task_app/core/constant/app_colors.dart';
import 'package:movie_task_app/view/ui/splash_screen/splash_screen.dart';
import 'core/database/db_helper.dart';

void main() {
  runApp(const MyApp());
  DBHelper.instance.initDB();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider<MovieBloc>(
      create: (context) => MovieBloc(),
      child: MaterialApp(
        title: 'Movie App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.whiteColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            surfaceTintColor: AppColors.whiteColor,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
