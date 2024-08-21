import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task_app/core/constant/app_colors.dart';
import 'package:movie_task_app/core/constant/navigator.dart';
import 'package:movie_task_app/view/ui/movie_screen/add_movie_screen.dart';
import 'package:movie_task_app/view/ui/movie_screen/favourite_movie_screen.dart';
import '../../../core/bloc/movie_bloc/movie_bloc.dart';
import '../../widget/movie_list_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  initState() {
    BlocProvider.of<MovieBloc>(context).add(GetMoviesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          child: const Icon(Icons.menu),
        ),
        centerTitle: true,
        title: const Text("Movie"),
      ),
      drawer: drawer(),
      body: SafeArea(
        child: BlocConsumer<MovieBloc, MovieState>(
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
                          onFavourite: () {
                            BlocProvider.of<MovieBloc>(context).add(
                              UpdateMovieEvent(
                                modelMovie: state.movies[index].copyWith(
                                    isFavourite:
                                        !state.movies[index].isFavourite),
                              ),
                            );
                          },
                          index: index,
                          movie: state.movies[index],
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

  Drawer drawer() {
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade400, shape: BoxShape.circle),
                child: const Icon(Icons.person)),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Guest User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text("guest@gmail.com"),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 1,
            ),
            drawerMenu(
                icon: Icons.add,
                title: "Add Movie",
                onTap: () {
                  NextScreen.pop(context);
                  NextScreen.normal(context, const AddMovieScreen());
                }),
            drawerMenu(
                icon: Icons.favorite_border,
                title: "Favourite Movie",
                onTap: () {
                  NextScreen.pop(context);
                  NextScreen.normal(context, const FavouriteMovieScreen());
                }),
          ],
        ),
      ),
    );
  }

  Widget drawerMenu(
      {required IconData icon,
      required String title,
      required void Function() onTap}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
