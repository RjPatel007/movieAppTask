part of 'movie_bloc.dart';

sealed class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MovieInitial extends MovieState {}

final class SuccessState extends MovieState {
  final List<ModelMovie> movies;

  SuccessState({required this.movies});

  @override
  List<Object?> get props => [movies];
}

final class ErrorState extends MovieState {
  final String message;

  ErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}