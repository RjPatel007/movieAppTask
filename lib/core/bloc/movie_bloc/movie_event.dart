part of 'movie_bloc.dart';

sealed class MovieEvent {}

class GetMoviesEvent extends MovieEvent {}

class GetFavouriteMoviesEvent extends MovieEvent {}

class AddMovieEvent extends MovieEvent {
  final ModelMovie modelMovie;

  AddMovieEvent({required this.modelMovie});
}

class UpdateMovieEvent extends MovieEvent {
  final ModelMovie modelMovie;
  final bool isFromFavourite;

  UpdateMovieEvent({this.isFromFavourite = false, required this.modelMovie});
}

class DeleteMovieEvent extends MovieEvent {
  final ModelMovie modelMovie;
  final bool isFromFavourite;

  DeleteMovieEvent({this.isFromFavourite = false , required this.modelMovie});
}
