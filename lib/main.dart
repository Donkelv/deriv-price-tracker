import 'package:deriv_price_tracker/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: const Size(375, 854),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Derive Price tracker',
            theme: ThemeData(
              
            
              primarySwatch: Colors.blue,
            ),
            home: const HomeScreen(),
          );
        }
      ),
    );
  }
}
