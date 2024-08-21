import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:movie_task_app/core/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_task_app/core/database/db_helper.dart';
import 'package:movie_task_app/core/models/model_movie.dart';

void main() {
  late MovieBloc movieBloc;
  late DBHelper dbHelper;

  setUp(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    dbHelper = DBHelper.instance;
    await dbHelper.initDB();
    await dbHelper.clearDB();
    movieBloc = MovieBloc();
  });

  tearDown(() async {
    movieBloc.close();
  });

  group('MovieBloc', () {
    test('Initial state is MovieInitial', () {
      expect(movieBloc.state, equals(MovieInitial()));
    });

    test('emits SuccessState with movies when GetMoviesEvent is added',
            () async {
          final movie = ModelMovie(
              title: 'Test Movie',
              description: 'Description',
              imagePath: 'path.jpg',
              isFavourite: false);
          await dbHelper.addMovies(movie);

          movieBloc.add(GetMoviesEvent());

          await expectLater(
            movieBloc.stream,
            emitsInOrder([
              isA<MovieInitial>(),
              isA<SuccessState>().having((state) => state.movies, 'movies', [
                isA<ModelMovie>().having((m) => m.title, 'title', 'Test Movie')
              ]),
            ]),
          );
        });

    test('emits SuccessState after adding a movie with AddMovieEvent',
            () async {
          final movie = ModelMovie(
              title: 'New Movie',
              description: 'Description',
              imagePath: 'path.jpg',
              isFavourite: false);

          movieBloc.add(AddMovieEvent(modelMovie: movie));
          await expectLater(
            movieBloc.stream,
            emitsInOrder([
              isA<MovieInitial>(),
              isA<SuccessState>().having((state) => state.movies, 'movies',
                  [isA<ModelMovie>().having((m) => m.title, 'title', 'New Movie')]),
            ]),
          );
        });

    test('emits SuccessState after updating a movie with UpdateMovieEvent',
            () async {
          final movie = ModelMovie(
              id: 1,
              title: 'Update Movie',
              description: 'Description',
              imagePath: 'path.jpg',
              isFavourite: false);
          await dbHelper.addMovies(movie);

          final updatedMovie = movie.copyWith(isFavourite: true);

          movieBloc.add(
              UpdateMovieEvent(modelMovie: updatedMovie, isFromFavourite: false));
          await expectLater(
            movieBloc.stream,
            emitsInOrder([
              isA<SuccessState>().having((state) => state.movies, 'movies', [
                isA<ModelMovie>().having((m) => m.isFavourite, 'isFavourite', true)
              ]),
            ]),
          );
        });

    test('emits SuccessState after deleting a movie with DeleteMovieEvent',
            () async {
          final movie = ModelMovie(
              id: 2,
              title: 'Delete Movie',
              description: 'Description',
              imagePath: 'path.jpg',
              isFavourite: false);
          await dbHelper.addMovies(movie);

          movieBloc
              .add(DeleteMovieEvent(modelMovie: movie, isFromFavourite: false));
          await expectLater(
            movieBloc.stream,
            emitsInOrder([
              isA<SuccessState>().having((state) => state.movies, 'movies', []),
            ]),
          );
        });

    test(
        'emits SuccessState with favorite movies when GetFavouriteMoviesEvent is added',
            () async {
          final favoriteMovie = ModelMovie(
              title: 'Favorite Movie',
              description: 'Description',
              imagePath: 'path.jpg',
              isFavourite: true);
          await dbHelper.addMovies(favoriteMovie);

          movieBloc.add(GetFavouriteMoviesEvent());
          await expectLater(
            movieBloc.stream,
            emitsInOrder([
              isA<SuccessState>().having((state) => state.movies, 'movies', [
                isA<ModelMovie>().having((m) => m.title, 'title', 'Favorite Movie')
              ]),
            ]),
          );
        });

  });
}