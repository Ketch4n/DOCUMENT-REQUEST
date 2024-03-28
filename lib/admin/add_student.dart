import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/user.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({super.key});

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _passController = TextEditingController();
  final _roleController = "student";
  final request = "false";

  Future done(
      {required String id,
      required String name,
      required String pass,
      required String role,
      required String request}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      final docUser = FirebaseFirestore.instance.collection('Student').doc(id);

      final json = {
        'id': id,
        'name': name,
        'password': pass,
        'role': role,
        'request': request,
      };
      await docUser.set(json);
    } catch (e) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
    }
    Navigator.of(context).pop(false);

    Navigator.of(context).pop(false);
    message_sign();
  }

  Future message_sign() async {
    await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "SUCCESS !",
              style: TextStyle(color: Colors.green, fontFamily: "NexaBold"),
            ),
            content: const Text(
              'Student Registered Successfully',
              style: TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  // FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String i = _idController.text.trim();
            String n = _nameController.text.trim();
            String p = _passController.text.trim();
            if (i.isEmpty) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please enter ID"),
                  duration: Duration(milliseconds: 2000),
                ),
              );
            } else if (n.isEmpty) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please enter Name"),
                  duration: Duration(milliseconds: 2000),
                ),
              );
            } else if (p.isEmpty) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please enter Password"),
                  duration: Duration(milliseconds: 2000),
                ),
              );
            } else {
              final id = _idController.text;
              final name = _nameController.text;
              final pass = _passController.text;
              final role = _roleController;
              const request = "false";
              done(
                id: id,
                name: name,
                pass: pass,
                role: role,
                request: request,
              );
            }
          },
          child: const Icon(Icons.done),
          backgroundColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    width: double.infinity,
                    height: 100,
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
                    child: Center(
                      child: Text(
                        "Add New Student",
                        style: TextStyle(fontFamily: "NexaBold"),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                    width: double.infinity,
                    height: 300,
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
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
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
                              hintText: 'ID',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
                            controller: _nameController,
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
                              hintText: 'Name',
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: TextField(
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
                            ),
                          ),
                        ),
                        Center(
                            child: Column(children: [
                          SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                "CANCEL",
                                style: TextStyle(
                                    color: Colors.blue, fontFamily: "NexaBold"),
                              ))
                        ]))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
