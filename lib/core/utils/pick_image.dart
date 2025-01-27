import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  try{
    if (xFile != null) {
    return File(xFile.path);
  } else {
    return null;
  }
  }catch(e){
    debugPrint(e.toString());
    return null;
  }
}
