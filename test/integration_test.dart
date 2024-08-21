import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_task_app/core/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_task_app/view/ui/home_screen/home_screen.dart';
import 'package:movie_task_app/core/database/db_helper.dart';
import 'package:movie_task_app/core/models/model_movie.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUpAll(() async {
    await DBHelper.instance.initDB();
  });

  setUp(() async {
    final movies = await DBHelper.instance.getMovies();
    for (var movie in movies) {
      await DBHelper.instance.deleteMovie(movie);
    }
  });

  group('Movie List Tests', () {

    testWidgets('Displays "Please add some movies" when no movies are present', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => MovieBloc()..add(GetMoviesEvent()),
            child: const HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text("Please add some movies"), findsOneWidget);
    });

    testWidgets('Add a movie and verify it appears in the list', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => MovieBloc()..add(GetMoviesEvent()),
            child: const HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text("Please add some movies"), findsOneWidget);

      final testMovie = ModelMovie(
        title: "New Test Movie",
        description: "New Test Description",
        imagePath: "assets/images/animal_movie_poster.avif",
      );

      await DBHelper.instance.addMovies(testMovie);

      BlocProvider.of<MovieBloc>(tester.element(find.byType(HomeScreen))).add(GetMoviesEvent());
      await tester.pumpAndSettle();

      expect(find.text("New Test Movie"), findsOneWidget);
    });

    testWidgets('Mark a movie as favorite and then unfavorite', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => MovieBloc()..add(GetMoviesEvent()),
            child: const HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      final testMovie = ModelMovie(
        title: "Favorite Test Movie",
        description: "Test Description",
        imagePath: "assets/images/animal_movie_poster.avif",
      );

      await DBHelper.instance.addMovies(testMovie);

      BlocProvider.of<MovieBloc>(tester.element(find.byType(HomeScreen))).add(GetMoviesEvent());
      await tester.pumpAndSettle();

      expect(find.text("Favorite Test Movie"), findsOneWidget);

      final movieItemFinder = find.text("Favorite Test Movie");
      expect(movieItemFinder, findsOneWidget);

      await tester.tap(find.byIcon(Icons.favorite_border).first);
      await tester.pumpAndSettle();

      final favoriteMovieFinder = find.byIcon(Icons.favorite);
      expect(favoriteMovieFinder, findsOneWidget);

      await tester.tap(find.byIcon(Icons.favorite).first);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite), findsNothing);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });

    testWidgets('Add and then delete a movie using Dismissible', (tester) async {
      final testMovie = ModelMovie(
        title: "Dismiss Test Movie",
        description: "Test Description",
        imagePath: "assets/images/animal_movie_poster.avif",
      );

      await DBHelper.instance.addMovies(testMovie);

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider(
            create: (_) => MovieBloc()..add(GetMoviesEvent()),
            child: const HomeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text("Dismiss Test Movie"), findsOneWidget);

      final dismissibleFinder = find.byWidgetPredicate(
            (widget) =>
        widget is Dismissible &&
            (widget.key as ValueKey<String>).value == "0",
      );

      expect(dismissibleFinder, findsOneWidget);

      await tester.drag(dismissibleFinder, const Offset(-1000, 0));
      await tester.pumpAndSettle();

      expect(find.text("Dismiss Test Movie"), findsNothing);
    });

  });
}
