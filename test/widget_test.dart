import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task_app/core/models/model_movie.dart';
import 'package:movie_task_app/view/ui/home_screen/home_screen.dart';
import 'package:movie_task_app/core/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_task_app/view/ui/movie_screen/add_movie_screen.dart';

void main() {
  group('HomeScreen and AddMovieScreen UI Tests', () {

    testWidgets('Displays movie list with correct UI components', (WidgetTester tester) async {
      final movieBloc = MovieBloc();
      final mockMovies = [
        ModelMovie(id: 1, title: 'Movie 1', description: 'Description 1', imagePath: 'path1.jpg', isFavourite: false),
        ModelMovie(id: 2, title: 'Movie 2', description: 'Description 2', imagePath: 'path2.jpg', isFavourite: true),
      ];

      movieBloc.emit(SuccessState(movies: mockMovies));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MovieBloc>(
            create: (_) => movieBloc,
            child: const HomeScreen(),
          ),
        ),
      );

      expect(find.text('Movie 1'), findsOneWidget);
      expect(find.text('Movie 2'), findsOneWidget);
      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsOneWidget);
    });

    testWidgets('Add Movie Form validates inputs and updates list', (WidgetTester tester) async {
      final movieBloc = MovieBloc();
      final mockMovies = <ModelMovie>[];

      movieBloc.emit(SuccessState(movies: mockMovies));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MovieBloc>(
            create: (_) => movieBloc,
            child: const AddMovieScreen(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), 'New Movie');
      await tester.enterText(find.byType(TextField).at(1), 'New Description');

      final imagePicker = find.byIcon(Icons.add).first;
      await tester.tap(imagePicker);
      await tester.pump();

      final submitButton = find.byKey(const Key('submit_button'));
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      expect(find.text('New Movie'), findsOneWidget);
    });

    testWidgets('Toggles favorite/unfavorite state', (WidgetTester tester) async {

      final movieBloc = MovieBloc();
      final mockMovies = [
        ModelMovie(id: 1, title: 'Movie 1', description: 'Description 1', imagePath: 'assets/images/animal_movie_poster.avif', isFavourite: false),
      ];


      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MovieBloc>(
            create: (_) => movieBloc,
            child: const HomeScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      movieBloc.emit(SuccessState(movies: mockMovies));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);

      await tester.tap(find.byIcon(Icons.favorite_border));
      movieBloc.emit(SuccessState(movies: [mockMovies.first.copyWith(isFavourite: true)]));

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite), findsOneWidget);

      expect(find.byIcon(Icons.favorite_border), findsNothing);

      await tester.tap(find.byIcon(Icons.favorite));
      movieBloc.emit(SuccessState(movies: [mockMovies.first.copyWith(isFavourite: false)]));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      expect(find.byIcon(Icons.favorite), findsNothing);
    });

  });
}
