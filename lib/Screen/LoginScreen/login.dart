import 'package:ars_dialog/ars_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_admin_panel/Screen/HomeScreen/home_screem.dart';
import 'package:web_admin_panel/services/firbase_services.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login-screen';

  const LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final GlobalKey<FormState> _key = GlobalKey();
  final FirebaseServices _services = FirebaseServices();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CustomProgressDialog progressDialog = CustomProgressDialog(
      context,
      blur: 5,
    );
    progressDialog.setLoadingWidget(const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.red)));

    Future.delayed(const Duration(seconds: 5));

    Future<void> _login({name, password}) async {
      try {
        progressDialog.show(useSafeArea: false);
        _services.getAdminCredential(name).then((value) async {
          if (value.exists) {
            if (value.data()['name'] == usernameController.text) {
              if (value.data()['password'] == passwordController.text) {
                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInAnonymously();
                  // ignore: unnecessary_null_comparison
                  if (userCredential != null) {
                    progressDialog.dismiss();
                    Get.to(HomeScreen());
                  }
                } catch (e) {
                  debugPrint('$e');
                }
              } else {
                progressDialog.dismiss();
                _services.showMyDialog(
                    context: context,
                    title: "Invalid Password",
                    message: "Please use correct password");
              }
            } else {
              progressDialog.dismiss();
              _services.showMyDialog(
                  context: context,
                  title: "Invalid Username",
                  message: "Please use correct username");
            }
          }
        });
      } catch (e) {
        debugPrint('$e');
        _services.showMyDialog(
            context: context, title: "Login", message: e.toString());
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          elevation: 0.0,
          title: const Text(
            "Admin Panel",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              print("Error is ${snapshot.error}");
              return const Center(
                child: Text("Connection failed!"),
              );
            }
            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFFFF5733), Colors.white],
                      stops: [1.0, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment(0.0, 0.0)),
                ),
                child: Center(
                    child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                bottomRight: Radius.circular(40))),
                        elevation: 5,
                        child: Container(
                          width: 350,
                          height: 350,
                          child: Form(
                            key: _key,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: TextFormField(
                                    controller: usernameController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please fill this field';
                                      } else {
                                        return null;
                                      }
                                    },
                                    //    controller: ,
                                    decoration: InputDecoration(
                                        icon: const Icon(Icons.mail),
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        hintText: "Murtaza",
                                        labelText: "Name",
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor))),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: TextFormField(
                                    controller: passwordController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please fill this field';
                                      } else if (value.length < 6) {
                                        return "Password is short";
                                      } else {
                                        return null;
                                      }
                                    },
                                    // controller: ,
                                    decoration: InputDecoration(
                                        focusColor:
                                            Theme.of(context).primaryColor,
                                        icon: const Icon(Icons.vpn_key),
                                        hintText: "******",
                                        labelText: "Password",
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Theme.of(context)
                                                    .primaryColor))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 40,
                                    child: FlatButton(
                                        color: Theme.of(context).primaryColor,
                                        onPressed: () {
                                          if (_key.currentState.validate()) {
                                            _login(
                                                name: usernameController.text,
                                                password:
                                                    passwordController.text);
                                          }
                                        },
                                        child: const Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))),
              );
            }
            // Otherwise, show something whilst waiting for initialization to complete
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
