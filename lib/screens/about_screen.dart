import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:mini_project/reusable_widgets/reusable_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 10, 0),
            child: Column(
              children: <Widget>[
                logoWidgetAbout("assets/images/logoVE.png"),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temp incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                BootstrapRow(
                  children: [
                    BootstrapCol(
                        sizes: 'col-6 col-sm-6 col-md-6 col-lg-6 col-xl-6',
                        child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "Visi",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ))),
                    BootstrapCol(
                        sizes: 'col-6 col-sm-6 col-md-6 col-lg-6 col-xl-6',
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Misi",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        )),
                  ],
                ),
                BootstrapRow(
                  children: [
                    BootstrapCol(
                        sizes: 'col-6 col-sm-6 col-md-6 col-lg-6 col-xl-6',
                        child: Container(
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temp incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                            textAlign: TextAlign.center,
                          ),
                        )),
                    BootstrapCol(
                      sizes: 'col-6 col-sm-6 col-md-6 col-lg-6 col-xl-6',
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod temp incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
