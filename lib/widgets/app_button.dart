
import 'package:flutter/material.dart';

 class AppButton  extends StatelessWidget {
   final String title;
   final void Function()? onPressed;

   const AppButton({super.key, required this.title, required this.onPressed});

   @override
   Widget build(BuildContext context) {
     return ElevatedButton(
       style: ElevatedButton.styleFrom(
         backgroundColor: Colors.deepPurple,
         maximumSize: Size(double.infinity, 60),
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(12),
         ),
       ),
       onPressed: onPressed,
       child: Text(
         title,
         style: TextStyle(fontSize: 20, color: Colors.white),
       ),
     );
   }
 } 