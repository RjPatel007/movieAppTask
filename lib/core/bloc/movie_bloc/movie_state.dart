part of 'movie_bloc.dart';

sealed class MovieState {}

final class MovieInitial extends MovieState {}

final class SuccessState extends MovieState {
  final List<ModelMovie> movies;

  SuccessState({required this.movies});
}

final class ErrorState extends MovieState {
  final String message;

  ErrorState({required this.message});
}
