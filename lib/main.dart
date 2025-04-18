import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p_student_management/Screens/Home/homescreen.dart';
import 'package:p_student_management/Screens/splashscreen.dart';
import 'package:p_student_management/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  debugDefaultTargetPlatformOverride = TargetPlatform.android;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentsListProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/':(context) => Splashscreen(),
          '/home':(context)=> Homescreen(),
        },
        // home: Splashscreen(),
      ),
    );
  }
}
