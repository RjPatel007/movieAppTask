import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task_app/core/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_task_app/core/common/common_function.dart';
import 'package:movie_task_app/core/constant/app_colors.dart';

import '../../core/models/model_movie.dart';

class MovieListWidget extends StatelessWidget {
  final ModelMovie movie;
  final bool isFromFavourite;
  final int index;
  final Function() onFavourite;

  const MovieListWidget(
      {super.key,
      required this.index,
      required this.onFavourite,
      required this.movie,
      this.isFromFavourite = false});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: Key(index.toString()),
      onDismissed: (direction) {
        BlocProvider.of<MovieBloc>(context).add(
          DeleteMovieEvent(modelMovie: movie, isFromFavourite: isFromFavourite),
        );
        CommonFunction.showSnackBar(
            context: context, isError: false, message: "Item $index dismissed");
      },
      background: Container(
        color: Colors.red.shade300,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: AppColors.whiteColor),
      ),
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 5))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.file(File(movie.imagePath),width: 80,fit: BoxFit.cover,)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    movie.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
            InkWell(
                key: Key('favorite_button_$index'),
                onTap: () {
                  onFavourite();
                },
                child: movie.isFavourite
                    ? const Icon(Icons.favorite, color: Colors.red,)
                    : const Icon(Icons.favorite_border))
          ],
        ),
      ),
    );
  }
}
