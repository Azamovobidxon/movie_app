import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/style/app_colors.dart';
import '../../../common/style/app_icons.dart';
import '../../../common/util/custom_extension.dart';
import '../../search/widget/search_screen.dart';
import '../../watch_list/widgets/watch_list_screen.dart';
import 'popular_movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late final PageController controller;
  int pageNumber = 0;

  late final FocusNode focus;

  void pageChange(int index) {
    pageNumber = index;

    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
    focus = FocusNode(debugLabel: 'search_text_field_focus');
  }

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.main,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          switch (pageNumber) {
            0 => 'What do you want to watch?',
            1 => 'Search',
            2 => 'Watch list',
            _ => '',
          },
          style: context.textTheme.titleMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
           PopularMovieScreen(),
          SearchScreen(),
          WatchListScreen(),
        ],
      ),
      bottomNavigationBar: ColoredBox(
        color: AppColors.blue,
        child: Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: NavigationBar(
            onDestinationSelected: pageChange,
            selectedIndex: pageNumber,
            destinations: [
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppIcons.home,
                  colorFilter: const ColorFilter.mode(
                    AppColors.blue,
                    BlendMode.srcATop,
                  ),
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppIcons.search,
                  colorFilter: const ColorFilter.mode(
                    AppColors.blue,
                    BlendMode.srcATop,
                  ),
                ),
                label: 'Search',
              ),
              NavigationDestination(
                icon: SvgPicture.asset(
                  AppIcons.save,
                  colorFilter: const ColorFilter.mode(
                    AppColors.blue,
                    BlendMode.srcATop,
                  ),
                ),
                label: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
