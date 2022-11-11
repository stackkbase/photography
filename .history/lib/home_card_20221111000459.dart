import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeCard extends GetView<HomeController> {
  HomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "“Wild Moments” Photographic Exhibition event held at Chitrakala Parishad displays 45 magical images,"
            "printed on high quality canvas with wooden border. "
            "Canvas prints are an eye-catching way to show off your favorite photos. Not only do they liven up any space, they’re an artistic way to update a room.",
            maxLines: 4,
            style: TextStyle(
                color: Colors.white60,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          )),
    );
  }
}
