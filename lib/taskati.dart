import 'package:flutter/material.dart';

class Taskati extends  StatelessWidget {
  const Taskati({super.key}) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskati',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Welcome to Taskati!'),
        ),
      ),
    );
  }
}