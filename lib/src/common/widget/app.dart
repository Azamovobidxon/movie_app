import 'package:flutter/material.dart';

import '../../feature/popular_movies/widget/home_screen.dart';
import '../style/app_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieApp',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppColors.main,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColors.white,
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          elevation: 2,

          backgroundColor: AppColors.main,
          indicatorColor: AppColors.main,
          indicatorShape: CircleBorder(),
          labelTextStyle: MaterialStatePropertyAll(
            TextStyle(
              color: AppColors.blue,
            ),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
