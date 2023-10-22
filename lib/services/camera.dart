import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraService {
  Future<XFile?> pickImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxHeight: 1800,
      maxWidth: 1800,
    );

    return pickedFile;
  }

  Future<CroppedFile?> cropImage(File? imageFile) async {
    if (imageFile != null) {
      CroppedFile? cropped = await ImageCropper()
          .cropImage(sourcePath: imageFile.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ], uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop it',
          toolbarColor: Colors.green[800],
          toolbarWidgetColor: Colors.white,
        ),
      ]);

      return cropped;
    }
    return null;
  }
}
