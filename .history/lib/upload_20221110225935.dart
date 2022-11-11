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
      backgroundColor: Color(0xff0B0910),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SliverToBoxAdapter(
                child: HomeCard(),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 30)),
              SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 1,
                children: _listItem.map(
                  (item) {
                    int idx = _listItem.indexOf(item);
                    return Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            if (idx == 3)
                              Get.toNamed(Routes.HISTORY);
                            else if (idx == 1)
                              Get.toNamed(Routes.LINK);
                            else if (idx == 0)
                              Get.toNamed(Routes.CREATE_INVOICE);
                            else if (idx == 2)
                              Get.toNamed(Routes.REWARDS);
                            else if (idx == 4)
                              // Get.toNamed(Routes.GLIM_CARD);
                              Get.bottomSheet(GenerateDialog(
                                onCancelButtonTap: (BuildContext context) {
                                  Get.back();
                                },
                              ));
                            else
                              Get.bottomSheet(GenerateDialog(
                                onCancelButtonTap: (BuildContext context) {
                                  Get.back();
                                },
                              ));
                          },
                          child: Container(
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
                            child: Center(
                              child: Text(
                                _listItem[idx],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(_listIcons[idx]),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
    );
  }
}
