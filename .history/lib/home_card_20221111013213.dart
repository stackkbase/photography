import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeCard extends GetView<HomeController> {
  HomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(color: Colors.white),
                color: Color(0xffb0B0910),
              ),
              height: 300,
              width: 400,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/red-carpet.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Event",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    )
                  ],
                ),
                Card(
                  color: Colors.transparent,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Text(
                        "Wildlife Photography Exhibition event "
                        " by Surya Prakash held at Karnataka Chitrakala Parishath from the 10th to 13th Novemeber 2022 displays 45 magical images "
                        "printed on canvas with wooden border. ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      )),
                )
              ]))),
      FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(color: Colors.white),
                color: Color(0xffb0B0910),
              ),
              height: 300,
              width: 400,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/frame-48.png",
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Prints",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 20))
                  ],
                ),
                Card(
                  color: Colors.transparent,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Text(
                        "All images are printed on high quality"
                        ", beautifully textured canvas weave giving you an artistic appearance to photographs",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      )),
                )
              ]))),
      FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.all(color: Colors.white),
                color: Color(0xffb0B0910),
              ),
              height: 300,
              width: 400,
              child: Column(children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/fast-delivery.png",
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Dispatch",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 20))
                  ],
                ),
                Card(
                  color: Colors.transparent,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Text(
                        "Ships within 7-business days",
                        style: TextStyle(fontSize: 20, color: Colors.white70),
                        textAlign: TextAlign.center,
                      )),
                )
              ])))
    ]);
  }
}
