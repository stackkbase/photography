import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';

class FirebaseApi {
  static UploadTask? uploadFile(
      String destination, Uint8List file, String? mime) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      final metadata = SettableMetadata(
        contentType: mime,
      );

      return ref.putData(file, metadata);
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
