import 'package:firebase_storage/firebase_storage.dart';

uploadFileToFirebaseStorage(file, path) async {
  final Reference storageReference = FirebaseStorage.instance.ref().child(path);
  final UploadTask uploadTask = storageReference.putFile(file);

  var downloadUrl =
      await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
  return downloadUrl;
}

uploadDataToFirebaseStorage(data, path) async {
  final Reference storageReference = FirebaseStorage.instance.ref().child(path);
  final UploadTask uploadTask = storageReference.putData(data);
  var downloadUrl =
      await (await uploadTask.whenComplete(() => null)).ref.getDownloadURL();
  return downloadUrl;
}
