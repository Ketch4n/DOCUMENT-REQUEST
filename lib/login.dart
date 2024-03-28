// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'admin/admin.dart';
import 'home.dart';
import 'main.dart';
import 'model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _idController = TextEditingController();
  final _passController = TextEditingController();
  double screenHeight = 0;
  double screenWidth = 0;
  bool _isObscure = true;

  // ignore: non_constant_identifier_names
  Future SignIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      String id = _idController.text.trim();
      String pass = _passController.text.trim();

      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection("Student")
          .where("id", isEqualTo: id)
          .get();

      DocumentSnapshot snap2 = await FirebaseFirestore.instance
          .collection('Student')
          .doc(snap.docs[0].id)
          .get();
      setState(() {
        User_details.user_id = snap2['id'];
        User_details.user_name = snap2['name'];
        User_details.user_role = snap2['role'];
      });

      // print(snap.docs[0]['password']);
      if (pass == snap.docs[0]['password'] &&
          snap.docs[0]['role'] == "student") {
        Navigator.of(context).pop(false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else if (pass == snap.docs[0]['password'] &&
          id == snap.docs[0]['id'] &&
          snap.docs[0]['role'] == "admin") {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('id', _idController.text);
        Navigator.of(context).pop(false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Incorrect"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      (e);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Account Not Found"),
          duration: Duration(seconds: 2),
        ),
      );
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  // @override
  // void dispose() {
  //   _idController.dispose();
  //   _passController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible =
        KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text(
                  "Confirm Exit",
                  style: TextStyle(color: Colors.black, fontFamily: "NexaBold"),
                ),
                content: const Text(
                  'Are you sure you want to exit ?',
                  style:
                      TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });

        return value == true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          bottomNavigationBar: const SizedBox(
            height: 40,
            child: BottomAppBar(
              color: Colors.green,
              // ignore: sort_child_properties_last
              child: Center(child: Text('Mobod Integrated School')),
              elevation: 0,
            ),
          ),
          body: Center(
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  isKeyboardVisible
                      ? const SizedBox(height: 20)
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/img/mobod.png',
                            width: screenWidth / 2,
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: 350,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Welcome",
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        ),
                        const Text("Login your Account"),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: TextField(
                            controller: _idController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Student ID',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: TextField(
                            obscureText: _isObscure,
                            controller: _passController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Password',
                              fillColor: Colors.grey[200],
                              filled: true,
                              suffixIcon: IconButton(
                                  icon: Icon(_isObscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              String id = _idController.text.trim();
                              String pass = _passController.text.trim();

                              if (id.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please Enter ID"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else if (pass.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please Enter Password"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                SignIn();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Text(
                                  'LOG IN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "NexaBold",
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
