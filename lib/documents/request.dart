// ignore_for_file: use_build_context_synchronously

import 'package:app/model/docu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../model/user.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String selectedValue = "First Year";
  String stats = "Pending";
  String docuNAME = Docu_type.docu;
  String studentID = User_details.user_id;
  String studentNAME = User_details.user_name;
  final _quantityController = TextEditingController();
  final inputController = StreamController<String>();

  Future submit(
      {required String quantity,
      required String studentID,
      required String studentNAME,
      required String yearLEVEL,
      required String status,
      required String docuNAME,
      required String date,
      required String time}) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      final docUser = FirebaseFirestore.instance
          .collection('Student')
          .doc(User_details.user_id)
          .collection('Request')
          .doc();
      // final docRequest = FirebaseFirestore.instance.collection('Record').doc();

      final json = {
        'no_of_copies': quantity,
        'student_id': studentID,
        'student_name': studentNAME,
        'status': status,
        'year_level': yearLEVEL,
        'document_name': docuNAME,
        'date': date,
        'time': time,
      };

      // final json2 = {
      //   'no_of_copies': quantity,
      //   'student_id': studentID,
      //   'student_name': studentNAME,
      //   'status': status,
      //   'year_level': yearLEVEL,
      //   'document_name': docuNAME,
      //   'date': date,
      //   'time': time,
      // };
      await docUser.set(json);
      final docUsers = FirebaseFirestore.instance
          .collection('Student')
          .doc(User_details.user_id);

      // final docRequest = FirebaseFirestore.instance.collection('Record').doc();

      docUsers.update({
        'request': 'true',
      });
      // await docRequest.set(json2);
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

  // ignore: non_constant_identifier_names
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
              'Document Requested Successfully',
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
  void dispose() {
    super.dispose;
    _quantityController.dispose();
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 60, bottom: 20),
                width: double.infinity,
                height: 200,
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
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 40),
                      child: Text(
                        "Request Info",
                        style: TextStyle(fontFamily: "NexaBold", fontSize: 20),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, //Center Row contents vertically,
                      children: [
                        const SizedBox(
                            width: 100,
                            child: Text(
                              "Student ID :",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "NexaBold"),
                            )),
                        SizedBox(
                          width: 110,
                          child: Text(
                            User_details.user_id,
                            style: const TextStyle(
                                fontSize: 16, fontFamily: "NexaBold"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, //Center Row contents horizontally,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, //Center Row contents vertically,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const SizedBox(
                            width: 100,
                            child: Text(
                              "Document Name :",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "NexaBold"),
                            )),
                        SizedBox(
                          width: 110,
                          child: Text(
                            Docu_type.document,
                            style: const TextStyle(
                                fontSize: 16, fontFamily: "NexaBold"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 20, left: 20),
                // height: 40,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                width: double.infinity,
                height: 240,
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
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            "Year Level :",
                            style:
                                TextStyle(fontSize: 16, fontFamily: "NexaBold"),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        value: selectedValue,
                        hint: const Text("Role"),
                        items: const [
                          DropdownMenuItem(
                            value: "First Year",
                            child: Text("First Year"),
                          ),
                          DropdownMenuItem(
                              value: "Second Year", child: Text("Second Year")),
                          DropdownMenuItem(
                            value: "Third Year",
                            child: Text("Third Year"),
                          ),
                          DropdownMenuItem(
                            value: "Fourth Year",
                            child: Text("Fourth Year"),
                          )
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedValue = newValue!;
                            inputController.add(newValue);
                          });
                        },
                      ),
                    ),
                    Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20, left: 30),
                          child: Text(
                            "No. of copies :",
                            style:
                                TextStyle(fontSize: 16, fontFamily: "NexaBold"),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Quantity',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      String quantity = _quantityController.text.trim();
                      if (quantity.isEmpty) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No. of copies is Empty"),
                            duration: Duration(milliseconds: 2000),
                          ),
                        );
                      } else {
                        final quantityController = _quantityController.text;
                        final studentID = User_details.user_id;
                        final studentNAME = User_details.user_name;
                        final yearLEVEL = selectedValue;
                        final stat = stats;
                        final docuNAME = Docu_type.docu;
                        final date =
                            DateFormat('MM/dd/yy').format(DateTime.now());
                        final time =
                            DateFormat('hh:mm a').format(DateTime.now());
                        submit(
                            quantity: quantityController,
                            studentID: studentID,
                            studentNAME: studentNAME,
                            yearLEVEL: yearLEVEL,
                            status: stat,
                            docuNAME: docuNAME,
                            date: date,
                            time: time);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 150,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "NexaBold"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      width: 150,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(2, 2),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: "NexaBold"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "First Year", child: Text("First Year")),
    const DropdownMenuItem(value: "Second Year", child: Text("Second Year")),
    const DropdownMenuItem(value: "Third Year", child: Text("Third Year")),
    const DropdownMenuItem(value: "Fourth Year", child: Text("Fourth Year")),
  ];
  return menuItems;
}
