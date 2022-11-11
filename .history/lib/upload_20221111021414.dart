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
    'Payments',
    'Link',
    'Points',
    'History',
    //'PoddL Card',
    //'Pay Bills',
  ];

  final List<String> _listIcons = [
    'assets/icons/invoice.png',
    'assets/icons/poddl-tp.png',
    'assets/icons/reward.png',
    'assets/images/agreement.png',
    //'assets/app/app-icon.png',
    //'assets/icons/utilities/electricity.png',
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
            SliverGrid.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 1.6,
              children: _listItem.map(
                (item) {
                  int idx = _listItem.indexOf(item);
                  return Container(
                    height: 600,
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
                        "assets/1.jpg",
                        height: 350,
                        width: 400,
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
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(backgroundColor: Colors.white),
                              onPressed: () {},
                              child: Text(
                                "Customize Size",
                                style: TextStyle(color: Colors.black),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(onPressed: () {}, child: Text("Buy"))
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
