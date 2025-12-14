import 'package:flutter/material.dart';
import 'package:taskati/screens/splash_screen.dart';

class Taskati extends  StatelessWidget {
  const Taskati({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     
      home:SplashScreen(),
    );
  }
}