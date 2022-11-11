import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeCard extends GetView<HomeController> {
  HomeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      
        fit: BoxFit.scaleDown,
        child: Container(
          decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(115, 120, 230, 1),
            Color.fromRGBO(115, 120, 230, 1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
            height: 400,
            width: 400,
            child: Card(
              color: ,
              child: Text(
                "Wild Moments” Photographic Exhibition event held at Chitrakala Parishad displays 45 magical images,"
                "printed on high quality canvas with wooden border. "
                "Canvas prints are an eye-catching way to show off your favorite photos. Not only do they liven up any space, they’re an artistic way to update a room.",
                style: TextStyle(fontSize: 20),
              ),
            )));
  }
}
