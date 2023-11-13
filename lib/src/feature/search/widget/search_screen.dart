import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/model/movie_model.dart';
import '../../../common/style/app_colors.dart';
import '../../../common/style/app_icons.dart';
import '../../../common/util/custom_extension.dart';
import '../../popular_movies/widget/home_screen.dart';
import '../../widget/movie_item.dart';
import '../data/search_repository.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final ISearchRepository repository;

  late final ScrollController controller;

  List<MovieModel> movies = [];
  String searchText = '';
  int page = 1;

  void onChange(String value) async {
    searchText = value;
    page = 1;

    movies = await repository.getMovies(
      page: page++,
      text: searchText,
    );
    setState(() {});
  }

  void pagination() async {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      movies.addAll(
        await repository.getMovies(
          page: page++,
          text: searchText,
        ),
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    repository = SearchRepository();
    controller = ScrollController()..addListener(pagination);
  }

  @override
  void dispose() {
    controller
      ..removeListener(pagination)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final focus = context.findAncestorStateOfType<HomeScreenState>()?.focus;
    return Scaffold(
      backgroundColor: AppColors.main,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              child: TextFormField(
                focusNode: focus,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                ),
                textAlignVertical: TextAlignVertical.center,
                onChanged: onChange,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textUnselected,
                  ),
                  fillColor: AppColors.searchBG,
                  filled: true,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset(
                      AppIcons.search,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SearchBody(
                movies: movies,
                isType: searchText.isNotEmpty,
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
    required this.movies,
    required this.isType,
    required this.controller,
  });

  final ScrollController controller;
  final List<MovieModel> movies;
  final bool isType;

  @override
  Widget build(BuildContext context) {
    if (!isType && movies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Text(
            'Find your movie by Type title, categories, years, etc',
            textAlign: TextAlign.center,
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else if (isType && movies.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.noResult),
              Text(
                ' We Are Sorry,We Can Not Find The Movie :( ',
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                ' Find your movie by Type title, categories, years, etc ',
                textAlign: TextAlign.center,
                style: context.textTheme.titleSmall?.copyWith(
                  color: AppColors.greyText,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        controller: controller,
        itemCount: movies.length,
        itemBuilder: (context, index) => MovieItem(
          movie: movies[index],
        ),
      );
    }
  }
}
