
 import 'package:flutter/material.dart';




  class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                ],

              ),
            ],
          ),

        )
      );
    }
  }