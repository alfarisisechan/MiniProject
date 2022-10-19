import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_project/reusable_widgets/reusable_widget.dart';
import 'package:mini_project/screens/home_screen.dart';
import 'package:mini_project/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _phoneTextController = TextEditingController();
  TextEditingController _addressTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                    "Masukan Password", false, _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Masukan Nomer HP", false, _phoneTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                    "Masukan Alamat", false, _addressTextController),
                const SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
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
