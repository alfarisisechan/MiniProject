import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_project/reusable_widgets/reusable_widget.dart';
import 'package:mini_project/screens/home_screen.dart';
import 'package:mini_project/screens/signin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    addUser() {
      return FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordTextController.text)
          .then((value) {
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user != null) {
            users.doc(user.uid).set({
              'uid': user.uid,
              'name': _nameTextController.text,
              'email': _emailTextController.text,
              'password': _passwordTextController.text,
              'phone': _phoneTextController.text,
              'address': _addressTextController.text
            }).then((value) {
              AlertDialog alert = AlertDialog(
                title: Text("Register Berhasil"),
                content: Container(
                  child: Text("Anda Berhasil Mendaftar, Silahkan Login"),
                ),
                actions: [
                  TextButton(
                      child: Text('Lanjut'),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()))),
                ],
              );
              showDialog(context: context, builder: (context) => alert);
            });
          }
        });
      });
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                reusableTextField(
                    "Masukan Nama Lengkap", false, _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Masukan Email", false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Masukan Password", true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Masukan Nomer HP", false, _phoneTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextFormField(
                    "Masukan Alamat", false, _addressTextController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, () {
                  addUser();
                }),
                SizedBox(
                  height: 10,
                ),
                SignInOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row SignInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Sudah punya Akun ? ",
            style: TextStyle(color: Colors.black87)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text("Login",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
