import 'package:booking_reserv/core/router/app_router.dart';
import 'package:booking_reserv/core/theme/app_theme.dart';
import 'package:booking_reserv/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Booking Reserv',
        themeMode: ThemeMode.system,
        darkTheme: appDarkTheme,
        theme: appLightTheme,
        routerConfig: AppRouter.createRouter(false),
      ),
    );
  }
}
