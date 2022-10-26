import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_project/screens/signin_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: FirebaseAuth.instance.userChanges(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting)
    //       return Center();
    //     else if (snapshot.hasError)
    //       return Center(child: SignInScreen());
    //     else {
    //       if (snapshot.data.email == null) {
    //         return SignInScreen();
    //       } else {
    //         var email = snapshot.data.email;
    //         return Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Text('$email', style: TextStyle(color: Colors.black)),
    //             Container(
    //               margin: EdgeInsets.all(50),
    //               child: RaisedButton(
    //                 child: new Text("Logout"),
    //                 onPressed: () {
    //                   FirebaseAuth.instance.signOut().then((value) {
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => SignInScreen()));
    //                   });
    //                 },
    //               ),
    //             ),
    //             Container(height: 20),
    //           ],
    //         );
    //       }
    //     }
    //   },
    // );
    return StreamBuilder(
      stream: _products.snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        if (streamSnapshot.hasData) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              streamSnapshot.data!.docs[index];
              return Container(
                  child: Align(
                      alignment: Alignment.center,
                      child: Column(children: [
                        SizedBox(height: 200),
                        Text(
                          documentSnapshot['name'],
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Text(
                          documentSnapshot['email'],
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Text(
                          documentSnapshot['address'],
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 10),
                        Text(
                          documentSnapshot['phone'],
                          style: TextStyle(fontSize: 24),
                        ),
                        SizedBox(height: 20),
                        RaisedButton(
                          child: new Text("Logout"),
                          onPressed: () {
                            FirebaseAuth.instance.signOut().then((value) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInScreen()));
                            });
                          },
                        ),
                      ])));
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
