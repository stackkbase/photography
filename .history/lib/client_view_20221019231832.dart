import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Trip photo widget template
    Widget tripPhotos = StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('documents').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error in receiving trip photos: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Not connected to the Stream or null');

            case ConnectionState.waiting:
              return Text('Awaiting for interaction');

            case ConnectionState.active:
              print("Stream has started but not finished");

              var totalPhotosCount = 0;
              List<DocumentSnapshot> tripPhotos;

              if (snapshot.hasData) {
                tripPhotos = snapshot.data!.docs;
                totalPhotosCount = tripPhotos.length;

                if (totalPhotosCount > 0) {
                  return GridView.builder(
                      itemCount: totalPhotosCount,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: (1 / .16),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 50,
                          width: 300,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              print('Tapped on thumbnail.');
                              print('Photo doc id: ${tripPhotos[index].id}');
                            },
                            child: ListTile(
                              tileColor: Color(0xff0B0910),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              leading: Icon(
                                Icons.download,
                                color: Colors.white,
                              ),
                              title: Text("Doc"),
                              trailing: Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      });
                }
              }

              return Center(
                  child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 50.0),
                  ),
                  const Text(
                    "No Files uploaded",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ));

            case ConnectionState.done:
              return const Text('Streaming is done');
          }
        });

    return Scaffold(
      backgroundColor: Color(0xff263238),
      appBar: AppBar(
        backgroundColor: Color(0xff263238),
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Your Files'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            tripPhotos,
          ],
        ),
      ),
    );
  }
}
