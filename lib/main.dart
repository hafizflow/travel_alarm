import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'helpers/notification_helper.dart';
import 'helpers/storage_helper.dart';
import 'constants/app_colors.dart';
import 'features/onboarding/views/onboarding_screen.dart';
import 'features/onboarding/controllers/onboarding_controller.dart';
import 'features/location/views/location_screen.dart';
import 'features/location/controllers/location_controller.dart';
import 'features/home/views/home_screen.dart';
import 'features/home/controllers/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize storage
  await StorageHelper().initialize();

  // Initialize notifications
  await NotificationHelper().initialize();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.primaryBlue,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final hasCompletedOnboarding = StorageHelper().hasCompletedOnboarding;
    // final initialRoute = hasCompletedOnboarding ? '/home' : '/onboarding';
    final initialRoute = '/onboarding';

    return ScreenUtilInit(
      designSize: const Size(360, 800), // iPhone 14 Pro size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Travel Alarm',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundDark,
            primaryColor: AppColors.accentPurple,
            fontFamily: 'SF Pro',
            useMaterial3: true,
          ),
          initialRoute: initialRoute,
          getPages: [
            GetPage(
              name: '/onboarding',
              page: () => const OnboardingScreen(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => OnboardingController());
              }),
            ),
            GetPage(
              name: '/location',
              page: () => const LocationScreen(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => LocationController());
              }),
            ),
            GetPage(
              name: '/home',
              page: () => const HomeScreen(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => HomeController());
              }),
            ),
          ],
        );
      },
    );
  }
}
