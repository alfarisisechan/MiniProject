import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:mini_project/reusable_widgets/reusable_widget.dart';
import 'package:mini_project/screens/sigup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final urlImages = [
    'https://i0.wp.com/rimbakita.com/wp-content/uploads/2019/08/sukarelawan.jpg',
    'https://img.okezone.com/content/2015/12/11/65/1265308/lima-hal-penting-sebelum-menjadi-volunteer-HGFVWeKajJ.jpg',
    'https://radarlampung.disway.id/upload/2a6e9eb9b34168c9d78edcea53e10f46.jpeg'
  ];
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('class_schedules');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
              child: Row(
            children: [
              SizedBox(width: 20),
              logoWidgets("assets/images/logoVE.png")
            ],
          )),
          Container(
            child: CarouselSlider.builder(
              options: CarouselOptions(height: 180, autoPlay: true),
              itemCount: urlImages.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage, index);
              },
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                  child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Event',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)))),
            ],
          ),
          Container(
            transform: Matrix4.translationValues(0.0, -15.0, 0.0),
            child: StreamBuilder(
              stream: _products.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 20,
                            crossAxisCount: 2,
                            mainAxisSpacing: 5),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      streamSnapshot.data!.docs[index];
                      return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Container(
                                        constraints:
                                            BoxConstraints(maxHeight: 470),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                8.0))),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch, // add this
                                                  children: <Widget>[
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                8.0),
                                                        topRight:
                                                            Radius.circular(
                                                                8.0),
                                                      ),
                                                      child: Image.network(
                                                          documentSnapshot[
                                                              'image'],
                                                          height: 200,
                                                          fit: BoxFit.fill),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        top: 5,
                                                      ),
                                                      child: ListTile(
                                                          title: Text(
                                                            documentSnapshot[
                                                                'title'],
                                                            maxLines: 2,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          subtitle: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Text(
                                                              documentSnapshot[
                                                                  'description'],
                                                              maxLines: 3,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    0.5,
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    Container(
                                                        child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 25,
                                                          right: 25,
                                                          top: 10),
                                                      child: TextButton(
                                                        style: TextButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    Color
                                                                        .fromRGBO(
                                                                            87,
                                                                            144,
                                                                            255,
                                                                            1)),
                                                        onPressed: () {
                                                          var judul =
                                                              documentSnapshot[
                                                                  'title'];
                                                          var gambar =
                                                              documentSnapshot[
                                                                  'image'];
                                                          var tanggal =
                                                              documentSnapshot[
                                                                  'date'];
                                                          var waktu =
                                                              documentSnapshot[
                                                                  'time'];
                                                          CollectionReference
                                                              activities =
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'volunteer');
                                                          FirebaseAuth.instance
                                                              .authStateChanges()
                                                              .listen((User?
                                                                  activity) {
                                                            if (activity !=
                                                                null) {
                                                              activities.add({
                                                                'email':
                                                                    activity
                                                                        .email,
                                                                'title': judul,
                                                                'image': gambar,
                                                                'date': tanggal,
                                                                'time': waktu
                                                              }).then((value) {
                                                                AlertDialog
                                                                    alert =
                                                                    AlertDialog(
                                                                  title: Text(
                                                                      "Berhasil"),
                                                                  content:
                                                                      Container(
                                                                    child: Text(
                                                                        "Anda Berhasil Mendaftar Sebagai Volunteer"),
                                                                  ),
                                                                  actions: [
                                                                    TextButton(
                                                                        child: Text(
                                                                            'Lanjut'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        })
                                                                  ],
                                                                );
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            alert);
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                          "Volunteer",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )),
                                                    Container(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 25,
                                                                    right: 25,
                                                                    top: 5,
                                                                    bottom: 25),
                                                            child:
                                                                OutlinedButton(
                                                              onPressed: () {
                                                                var judul =
                                                                    documentSnapshot[
                                                                        'title'];
                                                                var gambar =
                                                                    documentSnapshot[
                                                                        'image'];
                                                                var tanggal =
                                                                    documentSnapshot[
                                                                        'date'];
                                                                var waktu =
                                                                    documentSnapshot[
                                                                        'time'];
                                                                CollectionReference
                                                                    activities =
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'participant');
                                                                FirebaseAuth
                                                                    .instance
                                                                    .authStateChanges()
                                                                    .listen((User?
                                                                        activity) {
                                                                  if (activity !=
                                                                      null) {
                                                                    activities
                                                                        .add({
                                                                      'email':
                                                                          activity
                                                                              .email,
                                                                      'title':
                                                                          judul,
                                                                      'image':
                                                                          gambar,
                                                                      'date':
                                                                          tanggal,
                                                                      'time':
                                                                          waktu
                                                                    }).then((value) {
                                                                      AlertDialog
                                                                          alert =
                                                                          AlertDialog(
                                                                        title: Text(
                                                                            "Berhasil"),
                                                                        content:
                                                                            Container(
                                                                          child:
                                                                              Text("Anda Berhasil Mendaftar Sebagai Participant"),
                                                                        ),
                                                                        actions: [
                                                                          TextButton(
                                                                              child: Text('Lanjut'),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              })
                                                                        ],
                                                                      );
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder: (context) =>
                                                                              alert);
                                                                    });
                                                                  }
                                                                });
                                                              },
                                                              child: const Text(
                                                                  'Participant'),
                                                            )))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.stretch, // add this
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0),
                                  ),
                                  child: Image.network(
                                      documentSnapshot['image'],
                                      height: 150,
                                      fit: BoxFit.fill),
                                ),
                                ListTile(
                                  title: Text(
                                    documentSnapshot['title'],
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                }
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                20,
                                MediaQuery.of(context).size.height * 0.2,
                                20,
                                0),
                            child: Column(children: <Widget>[
                              logoWidget("assets/images/logoVE.png"),
                              SizedBox(
                                height: 30,
                              ),
                              Text('Data Masih Kosong')
                            ]))));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}
