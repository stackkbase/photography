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
          width: 400,
          padding: const EdgeInsets.only(top: 200),
          child: CustomScrollView(
            slivers: [
              SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 0.5,
                children: _listItem.map(
                  (item) {
                    int idx = _listItem.indexOf(item);
                    return InkWell(
                      onTap: () async {
                        if (idx == 3) {
                          await auth.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        } else if (idx == 1) {
                          if (uploading == true) return;
                          if (fileName == '') {
                            _showDialog();
                            return;
                          }
                          uploadFile();
                        } else if (idx == 0)
                          selectFile();
                        else if (idx == 2)
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClientPage(
                                      title: widget.uid!,
                                    )),
                          );
                      },
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        tileColor: Colors.white,
                        title: Padding(
                            padding: EdgeInsets.only(top: 35),
                            child: Text(
                              _listItem[idx],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )),
                        leading: Padding(
                            padding: EdgeInsets.only(top: 35),
                            child: Image.asset(_listIcons[idx])),
                      ),
                    );
                  },
                ).toList(),
              ),
              SliverToBoxAdapter(
                  child: SizedBox(
                height: 10,
              )),
              SliverToBoxAdapter(
                  child: Visibility(
                      visible: widget.email == 'klmn.nandini@gmail.com',
                      //visible: widget.email == 'kushal@poddl.work',
                      child: Center(
                          child: SizedBox(
                              width: 300,
                              child: InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminPage(
                                                title: widget.uid!,
                                              )),
                                    );
                                  },
                                  child: const ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10))),
                                    tileColor: Colors.blueGrey,
                                    leading: Icon(
                                      Icons.file_present_rounded,
                                      color: Colors.white,
                                    ),
                                    title: Text(
                                      'Admin Page',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_right_sharp,
                                      color: Colors.white,
                                    ),
                                  )))))),

              SliverToBoxAdapter(
                  child: SizedBox(
                height: 100,
                width: 400,
                child: Lottie.asset(
                  'assets/loading.json',
                  repeat: uploading == true,
                ),
              )),
              SliverToBoxAdapter(
                  child: Visibility(
                visible: fileName != '',
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                  tileColor: Colors.blueGrey,
                  leading: InkWell(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onTap: () {
                      fileName = '';
                      setState(() {});
                    },
                  ),
                  title: Text(fileName, style: TextStyle(color: Colors.white)),
                  trailing: ElevatedButton(
                    child: Text('Upload'),
                    onPressed: uploadFile,
                  ),
                ),
              )),
              //const SizedBox(height: 20),
              SliverToBoxAdapter(
                  child: SizedBox(
                      height: 50,
                      width: 150,
                      child: Visibility(
                          visible: uploading,
                          child: const Text(
                            'Uploading..',
                            style: TextStyle(color: Colors.white),
                          )))),
              /*   const SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                  child: SizedBox(
                      height: 50,
                      width: 300,
                      child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientPage(
                                        title: widget.uid!,
                                      )),
                            );
                          },
                          child: const ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            tileColor: Color(0xff00acc1),
                            leading: Icon(
                              Icons.file_present_rounded,
                              color: Colors.black,
                            ),
                            title: Text(
                              'View Your Files',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.arrow_right_sharp,
                              color: Colors.black,
                            ),
                          )))),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              Visibility(
                  visible: widget.email == 'klmn.nandini@gmail.com',
                  //visible: widget.email == 'kushal@poddl.work',
                  child: Center(
                      child: SizedBox(
                          width: 300,
                          child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminPage(
                                            title: widget.uid!,
                                          )),
                                );
                              },
                              child: const ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                tileColor: Colors.blueGrey,
                                leading: Icon(
                                  Icons.file_present_rounded,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Admin Page',
                                  style: TextStyle(color: Colors.white),
                                ),
                                trailing: Icon(
                                  Icons.arrow_right_sharp,
                                  color: Colors.white,
                                ),
                              ))))),
              // Text(
              //   'Signed In as: ' + widget.email!,
              //   style: const TextStyle(color: Colors.white),
              // ),
              const SliverToBoxAdapter(
                  child: SizedBox(
                height: 20,
              )),
              SliverToBoxAdapter(
                  child: SizedBox(
                      width: 300,
                      child: InkWell(
                          onTap: () async {
                            await auth.signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: const ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            tileColor: Colors.redAccent,
                            title: Text(
                              'Sign Out',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Icon(
                              Icons.logout_sharp,
                              color: Colors.black,
                            ),
                          )))), */
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
