import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/model/movie_model.dart';
import '../../../common/service/db_service.dart';
import '../../../common/style/app_colors.dart';
import '../../../common/style/app_icons.dart';
import '../../../common/util/custom_extension.dart';
import '../../widget/movie_item.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({super.key});

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final List<MovieModel> movies = [];

  void getMovies() async {
    movies.clear();

    final storageMovies =
        (await $storage).getStringList(StorageKeys.movies.key);

    if (storageMovies != null) {
      for (final e in storageMovies) {
        final json =
            const JsonDecoder().cast<String, Map<String, Object?>>().convert(e);
        final model = MovieModel.fromJson(json);

        movies.add(model);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      body: movies.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(AppIcons.emptyBox),
                    Text(
                      'There is no movie yet!',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Find your movie by Type title, categories,years,etc',
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleSmall?.copyWith(
                        color: AppColors.greyText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              itemCount: movies.length,
              itemBuilder: (context, index) => MovieItem(
                movie: movies[index],
              ),
            ),
    );
  }
}
