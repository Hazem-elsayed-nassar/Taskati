import 'package:flutter/material.dart';
import 'package:taskati/widgets/app_button.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  pickimageFromCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: Icon(Icons.person, size: 150, color: Colors.deepPurple),
              ),
              SizedBox(height: 30),
              AppButton(
                title: 'Upload From Camera ',
                onPressed: () {
                  pickimageFromCamera();
                },
              ),
              SizedBox(height: 20),
              AppButton(title: 'Uploadd From Gallery', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
