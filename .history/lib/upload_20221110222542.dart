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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'client_view.dart';
import 'admin_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';

class MainPage extends StatefulWidget {
  MainPage({this.uid, this.email});
  final String? uid;
  final String? email;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  UploadTask? task;
  File? file;
  String fileName = "";
  String? mimeType = "";
  bool uploading = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  final List<String> _listItem = [
    'Select File',
    'Upload',
    'View Files',
    'Sign Out',
    // 'Admin',
    //'Pay Bills',
  ];

  final List<String> _listIcons = [
    'folder.png',
    'submit.png',
    'file.png',
    'shutdown.png',
    // 'admin.png'
    //'assets/app/app-icon.png',
    //'assets/icons/utilities/electricity.png',
  ];

  List<IconData> _icons = [
// The underscore declares a variable as private in dart.
    Icons.file_open,
    Icons.upload_file,
    Icons.folder,
    Icons.logout
  ];

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.fromLTRB(5, 50, 5, 10),
            child: AlertDialog(
              elevation: 24.0,
              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.all(Radius.circular(40.0))
              // ),
              backgroundColor: Colors.blueGrey,
              title: null,
              content: Text(
                'Please select a file to upload',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              actions: <Widget>[
                ElevatedButton(
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
    // fileName = file != null ? basename(file!.path) : 'No File Selected';

    return Scaffold(
      backgroundColor: Color(0xff0B0910),
      body: SafeArea(
        child: Center(
            child: Container(
          width: 600,
          height: 700,
          padding: const EdgeInsets.only(top: 200),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                  child: Row(children: [
                SizedBox(
                  height: 500,
                  width: 200,
                  child: Image.asset('assets/banner.jpeg'),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Enter Gallery",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ])),
            ],
          ),
        )),
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

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('uid');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? imageUrl = prefs.getString('imageUrl');

    var collectionRef = FirebaseFirestore.instance.collection('documents');

    await collectionRef.add({
      'uid': uid,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'fileName': fileName,
      'downloadUrl': downloadUrl,
      'timestamp': DateTime.now(),
    });

    bytesFile = null;
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
