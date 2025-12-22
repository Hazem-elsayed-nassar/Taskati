import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/screens/home_screen.dart';
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
  final TextEditingController nameController = TextEditingController();

  void pickimageFromCamera() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  void pickimageFromGallery() async {
    photo = await picker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: photo == null,
                replacement: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.black,
                  backgroundImage: Image.file(File(photo?.path ?? '')).image,
                ),
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    size: 150,
                    color: Colors.deepPurple,
                  ),
                ),
              ),

              SizedBox(height: 30),
              AppButton(
                title: 'Upload From Camera ',
                onPressed: () {
                  pickimageFromCamera();
                },
              ),
              SizedBox(height: 20),
              AppButton(
                title: 'Uploadd From Gallery',
                onPressed: () {
                  pickimageFromGallery();
                },
              ),
              SizedBox(height: 20),
              Divider(thickness: 2),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  labelText: 'Enter Your Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
              ),
              SizedBox(height: 30),
              AppButton(
                title: 'Submit',
                onPressed: () {
                  if (photo != null && nameController.text.isNotEmpty) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (c) => HomeScreen(
                          userName: nameController.text,
                          userImage: File(photo!.path),
                        ),
                      ),
                      (e) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
