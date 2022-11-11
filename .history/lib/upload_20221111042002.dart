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
import 'home_controller.dart';
import 'home_card.dart';

class HomeView extends GetView<HomeController> {
  final List<String> _listItem = [
    'assets/1.jpg',
    'assets/2.jpg',
    'assets/3.jpg',
    'assets/4.jpg',
    'assets/5.jpg',
    'assets/6.jpg',
    'assets/7.jpg',
    'assets/8.jpg',
    'assets/9.jpg',
    'assets/10.jpg',
    'assets/11.jpg',
    'assets/12.jpg',
    'assets/13.jpg',
    'assets/14.jpg',
    'assets/15.jpg',
    'assets/16.jpg',
    'assets/17.jpg',
    'assets/18.jpg',
    'assets/19.jpg',
    'assets/20.jpg',
    'assets/21.jpg',
    'assets/22.jpg',
    'assets/23.jpg',
    'assets/24.jpg',
    'assets/25.jpg',
    'assets/26.jpg',
    'assets/27.jpg',
    'assets/28.jpg',
    'assets/29.jpg',
    'assets/30.jpg',
    'assets/31.jpg',
    'assets/32.jpg',
    'assets/33.jpg',
    'assets/34.jpg',
    'assets/35.jpg',
    'assets/36.jpg',
    'assets/37.jpg',
    'assets/38.jpg',
    'assets/39.jpg',
  ];

  final List<String> _listIcons = [
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    'assets/1.jpg',
    //'assets/app/app-icon.jpg',
    //'assets/icons/utilities/electricity.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffb0B0910),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                child: HomeCard(),
                height: 400,
                width: 400,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverToBoxAdapter(
              child: Center(
                  child: ListTile(
                      tileColor: Color(0xff101828),
                      leading: Image.asset(
                        "assets/exhibition.png",
                        height: 40,
                        width: 40,
                      ),
                      title: Text(
                        "Please visit the Exhibition for the most impactful experience",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 30)),
            SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 2,
              children: _listItem.map(
                (item) {
                  int idx = _listItem.indexOf(item);
                  return Container(
                    height: 700,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xff101828),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        _listItem[idx],
                        height: 450,
                        width: 400,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Nature’s Fiery Canvas",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                          width: 250,
                          child: Text(
                            "As the sky bleeds gold and crimson, it gets accentuated by the silhouettes of two elephants retiring home.",
                            style: TextStyle(color: Colors.blueGrey),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Frame Dimension",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(
                          width: 250,
                          child: Text(
                            "24H X 36W",
                            style: TextStyle(color: Colors.blueGrey),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                              onPressed: () {},
                              child: Text(
                                "Customize Size",
                                style: TextStyle(color: Colors.black),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              child: Text("Buy"),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(115, 120, 230, 1)),
                              ))
                        ],
                      )
                    ]),
                  );
                },
              ).toList(),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
