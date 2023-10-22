import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask? startUpload(String filePath, File file) {
    try {
      return _storage.ref().child(filePath).putFile(file);
    } on FirebaseException catch (e) {
      print(e.code);
      return null;
    }
  }

  Future<String> getUrl(String path) async {
    return await _storage.ref().child(path).getDownloadURL();
  }
}
