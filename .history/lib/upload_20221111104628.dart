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
import 'package:universal_html/html.dart' as html;
import 'center_dialog.dart';
import 'package:flutter/cupertino.dart';

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

  final List<String> _listSizes = [
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
    '24H X 36H (inches)',
  ];

  final List<String> _listCaption = [
    'Nature has it’s way of painting for scenes you can only Imagine.',
    'Kilimanjaro, rising high above the African plains and watching over the elephants.',
    'The power and serenity of Africa. A moment I will never forget. Elephant with Mt. Kilimanjaro at the Backdrop.',
    'Nature’s Artistry, Leopards in Rain. That’s how Mara is. Simply fascinating.',
    'All life, no matter what shape or form it comes in, is equally miraculous, vulnerable and important.',
    'The golden moment. Sometimes you only have seconds of perfect light when photographing wildlife.',
    'Treasure of India - The One Horned Rhino at dusk.',
    'As the curtains are drawn on the biggest stage of the animal kingdom, these Imapalas are waiting for another Sunrise.',
    'Male and female, fire and rain, hunger and prey, night and day. It’s the rhythm of life, it’s life on the plains. ',
    'Lions speak to our souls. They don’t use any words, but you understand everything they say. ',
    'Mom & me. We are, Because you are! There is hardly anything more Universal than mothers.',
    'The Great wide open with magical skies, home of a Giraffe.',
    'One for all, all for one - MOTHER',
    'Fascinating Corbett - A Paradise for Elephants',
    'We don’t see nature with our eyes, but with our understandings and our hearts.',
    'One Planet - One Life - One Soul',
    'A voracious hunter by nature, a leopard scours the field for a prey, seconds before jumping in.',
    'I try to portray souls, not just animals.',
    'Double Trouble - Ranthambore, a place where tigers rule and Thrive.',
    'There is something about elephants, that makes my heart slow down',
    ' Together is a wonderful place to be.',
    'The Next Kings soaking the most Divine Sunlight in Africa.',
    'A one in a Million moments, but to be lucky, you have to work hard. The ultimate Faceoff',
    ' In a flash & gone in seconds. That’s how tough it is to shoot wildlife.',
    'The Colour Bomb - Undoubtedly the Most Gorgeous Bird of the Western Ghats',
    'The Bee Jet - A precious Catch',
    'The Red Velvet - A beauty beyond words.',
    'A red-whiskered bulbul, perched on a branch, enjoys her fill and serenades the jungle.',
    'sparkling in the sun, hits the road for an adventurous expedition.',
    'Behind the first impression of any wild animal, there is a sentient being with emotional needs and the ability to feel.',
    'As the dusky sky churns out a new shade of orange, an elephant ponders and promenades by the stream.',
    'Fire and ice. Thunder and lull. There is a beautiful duality in a lion'
        "s soul.",
    'This tiger holds a furtive gaze, as it tiptoes through a thicket to catch a prey unawares.',
    ' Colours of the Planet - The Pleasure you get in spending time with Nature and creating these kind of Images is something Beyond Comparison.',
    'Tigers reign supreme in Ranthambore, as they engage in playful duels with one another.',
    'Two leopards proudly sit on a mound, dauntless in their disposition.',
    'There is no Greater Warrior than a Mother protecting her Child! One of the finest encounters in the wild which cannot be forgotten.',
    'On a mission to hunt, these spotted wild cats share some unexpected camaraderie.',
    'Staying true to her instincts, a mother imparts valuable lessons to her impressionable cub in the wild.',
    'Mothers are great...they do their best to make the lives of their children comfortable.',
    'There is something about elephants, that makes my heart slow down.',
    'Together is a wonderful place to be.',
    'The Next Kings soaking the most Divine Sunlight in Africa.',
    'A one in a Million moments, but to be lucky, you have to work hard. The ultimate Faceoff',
    'In a flash & gone in seconds. That’s how tough it is to shoot wildlife. ',
    'The Colour Bomb - Undoubtedly the Most Gorgeous Bird of the Western Ghats',
    'Nature’s Rules, sometimes it is harsh and we have to accept it. A wild Moment caught in Mara, Africa.',
    'The Bee Jet - A precious Catch. ',
    'The Red Velvet - A beauty beyond words. ',
    'Life on Earth. Big and small. Every species matter.',
    'Beauty comes in all Sizes.',
    'Lights & Shadows - No light like Rim Light. A sambar deer from the Southern Woods ',
    'Behind the first impression of any wild animal, there is a sentient being with emotional needs and the ability to feel',
    'Sunset is always Wiser than Sunrise because sunset has added the experience of an entire day to his soul! ',
    'India - The Tiger Land, in the world full of shades & reflections, the tiger rules in Silence & Invisibility.',
    'Colours of the Planet - The Pleasure you get in spending time with Nature and creating these kind of Images is something Beyond Comparison.',
    'There is no Greater Warrior than a Mother protecting her Child! One of the finest encounters in the wild which cannot be forgotten. ',
  ];

  final List<String> _listUrl = [
    'https://surya_photography.poddl.work/links/01',
    'https://surya_photography.poddl.work/links/02',
    'https://surya_photography.poddl.work/links/03',
    'https://surya_photography.poddl.work/links/04',
    'https://surya_photography.poddl.work/links/05',
    'https://surya_photography.poddl.work/links/06',
    'https://surya_photography.poddl.work/links/07',
    'https://surya_photography.poddl.work/links/08',
    'https://surya_photography.poddl.work/links/09',
    'https://surya_photography.poddl.work/links/10',
    'https://surya_photography.poddl.work/links/11',
    'https://surya_photography.poddl.work/links/12',
    'https://surya_photography.poddl.work/links/13',
    'https://surya_photography.poddl.work/links/14',
    'https://surya_photography.poddl.work/links/15',
    'https://surya_photography.poddl.work/links/16',
    'https://surya_photography.poddl.work/links/17',
    'https://surya_photography.poddl.work/links/18',
    'https://surya_photography.poddl.work/links/19',
    'https://surya_photography.poddl.work/links/20',
    'https://surya_photography.poddl.work/links/21',
    'https://surya_photography.poddl.work/links/22',
    'https://surya_photography.poddl.work/links/23',
    'https://surya_photography.poddl.work/links/24',
    'https://surya_photography.poddl.work/links/25',
    'https://surya_photography.poddl.work/links/26',
    'https://surya_photography.poddl.work/links/27',
    'https://surya_photography.poddl.work/links/28',
    'https://surya_photography.poddl.work/links/29',
    'https://surya_photography.poddl.work/links/30',
    'https://surya_photography.poddl.work/links/31',
    'https://surya_photography.poddl.work/links/32',
    'https://surya_photography.poddl.work/links/33',
    'https://surya_photography.poddl.work/links/34',
    'https://surya_photography.poddl.work/links/35',
    'https://surya_photography.poddl.work/links/36',
    'https://surya_photography.poddl.work/links/37',
    'https://surya_photography.poddl.work/links/38',
    'https://surya_photography.poddl.work/links/39',
  ];

  static openNewTab({String? setUrl, String? setTitle}) {
    return html.window.open(
      setUrl!,
      setTitle!,
    );
  }

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
              child: SizedBox(
                  width: 300,
                  height: 50,
                  child: Center(
                      child: ListTile(
                          tileColor: Color(0xff101828),
                          leading: Image.asset(
                            "assets/exhibition.png",
                            height: 30,
                            width: 30,
                          ),
                          title: Text(
                            "Visit the Exhibition between 11 am to 7:30 pm to view the framed photographs",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )))),
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
                      SizedBox(
                          width: 250,
                          child: Text(
                            _listCaption[idx],
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Frame Dimension",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      SizedBox(
                          width: 250,
                          child: Text(
                            "24H X 36W",
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
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
                              onPressed: () async {
                                await Get.dialog(
                                  CupertinoAlertDialog(
                                    content: new Text(
                                        "For customized frame sizes, please send us a request to surya_photography@yahoo.co.in. We will reach out as soon as possible"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        isDefaultAction: true,
                                        child: Text("Close"),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              child: Text(
                                "Customize Size",
                                style: TextStyle(color: Colors.black),
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                openNewTab(
                                    setTitle: "Surya Prakash Photography",
                                    setUrl: _listUrl[idx]);
                              },
                              child: Text("Buy"),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromRGBO(115, 120, 230, 1)),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 200,
                          child: Text(
                            "For custome sized frame, please send an email to surya_f3@yahoo.co.in. We will get in touch with you as soon as possible.",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ))
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
