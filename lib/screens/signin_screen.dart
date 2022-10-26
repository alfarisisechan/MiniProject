import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_project/reusable_widgets/reusable_widget.dart';
import 'package:mini_project/screens/first_screen.dart';
import 'package:mini_project/screens/home_screen.dart';
import 'package:mini_project/screens/sigup_screen.dart';
import 'package:mini_project/utils/color_utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/logoVE.png"),
                reusableTextField("Masukan Email", false, _emailTextController),
                SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    "Masukan Password", true, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FirstScreen()));
                  }).catchError((error) {
                    AlertDialog alert = AlertDialog(
                      title: Text("Login Gagal",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      content: Container(
                        child: Text("Email / Password yang anda masukan salah!",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      actions: [
                        TextButton(
                          child: Text('Kembali',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    );
                    showDialog(context: context, builder: (context) => alert);
                  });
                }),
                SignUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row SignUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Belum punya Akun ? ",
            style: TextStyle(color: Colors.black87)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text("Daftar",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );
  }
}
