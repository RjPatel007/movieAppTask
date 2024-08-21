import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task_app/core/models/model_movie.dart';
import '../../database/db_helper.dart';

part 'movie_event.dart';

part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    on<GetMoviesEvent>(_onGetMoviesEvent);
    on<AddMovieEvent>(_onAddMovieEvent);
    on<UpdateMovieEvent>(_onUpdateMovieEvent);
    on<DeleteMovieEvent>(_onDeleteMovieEvent);
    on<GetFavouriteMoviesEvent>(_onGetFavouriteMoviesEvent);
  }

  _onGetMoviesEvent(GetMoviesEvent event, Emitter<MovieState> emit) async {
    emit(MovieInitial());
    try {
      final movies = await DBHelper.instance.getMovies();
      emit(SuccessState(movies: movies));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onAddMovieEvent(AddMovieEvent event, Emitter<MovieState> emit) async {
    emit(MovieInitial());
    try {
      await DBHelper.instance.addMovies(event.modelMovie);
      final movies = await DBHelper.instance.getMovies();
      emit(SuccessState(movies: movies));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onUpdateMovieEvent(UpdateMovieEvent event, Emitter<MovieState> emit) async {
    try {
      await DBHelper.instance.updateMovie(event.modelMovie);

      final movies = event.isFromFavourite
          ? await DBHelper.instance.getFavoriteMovies()
          : await DBHelper.instance.getMovies();
      emit(SuccessState(movies: movies));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onDeleteMovieEvent(DeleteMovieEvent event, Emitter<MovieState> emit) async {
    try {
      await DBHelper.instance.deleteMovie(event.modelMovie);

      final movies = event.isFromFavourite
          ? await DBHelper.instance.getFavoriteMovies()
          : await DBHelper.instance.getMovies();
      emit(SuccessState(movies: movies));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  _onGetFavouriteMoviesEvent(
      GetFavouriteMoviesEvent event, Emitter<MovieState> emit) async {
    try {
      final movies = await DBHelper.instance.getFavoriteMovies();
      emit(SuccessState(movies: movies));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
