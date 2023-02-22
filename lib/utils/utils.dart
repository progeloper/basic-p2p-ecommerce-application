import 'dart:typed_data';

import 'package:amazon_clone/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white,
      elevation: 3.0,
      content: Text(
        content,
        style: const TextStyle(
          color: amazonOrangeAccent,
        ),
      ),
    ),
  );
}

pickImage(ImageSource source)async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? file = await _imagePicker.pickImage(source: source);
  if(file!=null){
    return file.readAsBytes();
  }
  return null;
}
