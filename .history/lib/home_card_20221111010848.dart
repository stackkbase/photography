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
                border: Border.all(color: Colors.blueAccent),
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
                        "Wild Moments” Photographic Exhibition event held at Chitrakala Parishad displays 45 magical images,"
                        "printed on high quality canvas with wooden border. "
                        "Canvas prints are an eye-catching way to show off your favorite photos. Not only do they liven up any space, they’re an artistic way to update a room.",
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                border: Border.all(color: Color(0xff455a64)),
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
                      width: 25,
                      height: 25,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text("Canvas",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 20))
                  ],
                ),
                Card(
                  color: Colors.transparent,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Text(
                        "Wild Moments” Photographic Exhibition event held at Chitrakala Parishad displays 45 magical images,"
                        "printed on high quality canvas with wooden border. "
                        "Canvas prints are an eye-catching way to show off your favorite photos. Not only do they liven up any space, they’re an artistic way to update a room.",
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
                border: Border.all(color: Color(0xff3e2723)),
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
                      width: 25,
                      height: 25,
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
                        "Wild Moments” Photographic Exhibition event held at Chitrakala Parishad displays 45 magical images,"
                        "printed on high quality canvas with wooden border. "
                        "Canvas prints are an eye-catching way to show off your favorite photos. Not only do they liven up any space, they’re an artistic way to update a room.",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                )
              ])))
    ]);
  }
}
