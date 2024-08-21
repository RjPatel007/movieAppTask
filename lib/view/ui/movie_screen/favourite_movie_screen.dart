import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task_app/core/constant/navigator.dart';

import '../../../core/bloc/movie_bloc/movie_bloc.dart';
import '../../widget/movie_list_widget.dart';

class FavouriteMovieScreen extends StatefulWidget {
  const FavouriteMovieScreen({super.key});

  @override
  State<FavouriteMovieScreen> createState() => _FavouriteMovieScreenState();
}

class _FavouriteMovieScreenState extends State<FavouriteMovieScreen> {
  @override
  void initState() {
    BlocProvider.of<MovieBloc>(context).add(GetFavouriteMoviesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          BlocProvider.of<MovieBloc>(context).add(GetMoviesEvent());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              NextScreen.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text("Favourite Movie"),
        ),
        body: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SuccessState) {
              return state.movies.isEmpty
                  ? const Center(
                      child: Text("Please add some movies"),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        return MovieListWidget(
                          movie: state.movies[index],
                          index: index,
                          isFromFavourite: true,
                          onFavourite: () {
                            BlocProvider.of<MovieBloc>(context).add(
                              UpdateMovieEvent(
                                isFromFavourite: true,
                                modelMovie: state.movies[index].copyWith(
                                    isFavourite:
                                        !state.movies[index].isFavourite),
                              ),
                            );
                          },
                        );
                      },
                    );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
