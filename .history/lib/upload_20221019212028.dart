import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'firebase_api.dart';
import 'button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:mime_type/mime_type.dart';
import 'package:lottie/lottie.dart';

class MyApp extends StatelessWidget {
  static final String title = 'Firebase Upload';

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(primarySwatch: Colors.green),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UploadTask? task;
  File? file;
  String fileName = "";
  String? mimeType = "";
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    // fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      backgroundColor: Color(0xff263238),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ButtonWidget(
                  text: 'Select File',
                  icon: Icons.attach_file,
                  onClicked: selectFile,
                ),
                SizedBox(width: 15),
                ButtonWidget(
                  text: 'Upload File',
                  icon: Icons.cloud_upload_outlined,
                  onClicked: uploadFile,
                )
              ]),
              SizedBox(height: 10),
              Text(
                fileName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              Container(
                height: 100,
                width: 300,
                child: Lottie.asset(
                  'assets/loading.json',
                  repeat: uploading == true,
                ),
              ),
              Visibility(
                  visible: uploading,
                  child: Text(
                    'Uploading..',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Uint8List? bytesFile;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    PlatformFile _file = result.files.single;
    bytesFile = _file.bytes;

    setState(() {
      fileName = _file.name.toString();
    });
  }

  Future uploadFile() async {
    if (bytesFile == null) return;
    final destination = 'files/$fileName';

    final Reference storageReference =
        FirebaseStorage.instance.ref().child(destination);

    setState(() {
      uploading = true;
    });

    UploadTask task = storageReference.putData(bytesFile!);
    var downloadUrl =
        await (await task.whenComplete(() => null)).ref.getDownloadURL();

    setState(() {
      uploading = false;
    });
    print('Download-Link: $downloadUrl');
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).toStringAsFixed(2);

            return Text(
              '$percentage %',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            );
          } else {
            return Container();
          }
        },
      );
}
