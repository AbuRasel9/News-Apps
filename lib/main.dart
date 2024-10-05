import 'package:flutter/material.dart';
import 'package:news_app/provider/home_headline_provider.dart';
import 'package:news_app/provider/internet_connectivity_check_provider.dart';
import 'package:news_app/utils/theme/app_theme_data.dart';
import 'package:news_app/view/home/home.dart';
import 'package:news_app/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeHeadlineProvider>(
          create: (context) => HomeHeadlineProviderImpl(),
        ),
        ChangeNotifierProvider(
          create: (context) => InternetConnectivityCheckProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightThemeData,
        // darkTheme: AppThemeData.darkThemeData,
        home: const SplashScreen(),
      ),
    );
  }
}
