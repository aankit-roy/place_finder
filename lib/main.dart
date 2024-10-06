import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:place_finder/model/provider/location_provider.dart';
import 'package:place_finder/ui/constants/app_colors.dart';
import 'package:place_finder/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Set the design size based on your UI
      minTextAdapt: true, // Allow text to adapt to screen size
      splitScreenMode: false, // Set to true if you want to enable split screen mode
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => LocationProvider()),
          ],
          child: MaterialApp(
            title: 'Place Finder',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              scaffoldBackgroundColor: AppColors.backgroundColor,
              useMaterial3: true,
            ),
            home: HomeScreen(),
          ),
        );
      },
    );
  }
}


