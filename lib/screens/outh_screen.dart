import 'package:flutter/material.dart';
import 'package:taskati/widgets/app_button.dart';


class OuthScreen extends StatelessWidget {
  const OuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.black,
              child: Icon(Icons.person, size: 150, color: Colors.deepPurple),
            ),
            SizedBox(height: 30),
             AppButton(title: 'Upload From Camera ', onPressed: () {  },),
            SizedBox(height: 20),
            AppButton(title: 'Uploadd From Gallery', onPressed: () {  },),
            
          ],
        ),
      ),
    );
  }
}
