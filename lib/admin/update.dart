import 'dart:async';

import 'package:app/model/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/user.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  String selectedValue = Request_details.docu_status;
  final inputController = StreamController<String>();

  // Navigator.of(context).pop(false);

  // message_sign();

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
              'Document Updated Successfully',
              style: TextStyle(color: Colors.black, fontFamily: "NexaRegular"),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  // FirebaseAuth.instance.signOut();
                  // Navigator.of(context).pop(false);
                  Navigator.of(context).pop(false);
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () async {
          String i = selectedValue;

          if (i == Request_details.docu_status) {
            // ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Select Status to Update"),
                duration: Duration(milliseconds: 2000),
              ),
            );
          } else {
            try {
              final docUsers = FirebaseFirestore.instance
                  .collection('Student')
                  .doc(Request_details.student_id)
                  .collection('Request')
                  .doc(Request_details.docID);
              // final docRequest = FirebaseFirestore.instance.collection('Record').doc();

              docUsers.update({
                'status': i,
                'date': DateFormat('MM/dd/yy').format(DateTime.now()),
              });

              message_sign();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Failed to Update status"),
                  duration: Duration(milliseconds: 2000),
                ),
              );
            }
          }

          // Navigator.of(context).pop(false);
          // Navigator.of(context).pop(false);
          // message_sign();
        },
        child: Icon(Icons.done),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Status'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
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
                          style:
                              TextStyle(fontSize: 16, fontFamily: "NexaBold"),
                        )),
                    SizedBox(
                      width: 110,
                      child: Text(
                        Request_details.student_id,
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
                          style:
                              TextStyle(fontSize: 16, fontFamily: "NexaBold"),
                        )),
                    SizedBox(
                      width: 110,
                      child: Text(
                        Request_details.docu_name,
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("select status"),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: DropdownButtonFormField(
                    value: selectedValue,
                    hint: const Text("Status"),
                    items: const [
                      DropdownMenuItem(
                        value: "Pending",
                        child: Text("Pending"),
                      ),
                      DropdownMenuItem(
                          value: "Accepted", child: Text("Accepted")),
                      DropdownMenuItem(
                        value: "Printing",
                        child: Text("Printing"),
                      ),
                      DropdownMenuItem(
                        value: "Signature",
                        child: Text("Signature"),
                      ),
                      DropdownMenuItem(
                        value: "Pickup",
                        child: Text("Pickup"),
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
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Text(
                        "CANCEL",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "Pending", child: Text("Pending")),
    const DropdownMenuItem(value: "Accepted", child: Text("Accepted")),
    const DropdownMenuItem(value: "Printing", child: Text("Printing")),
    const DropdownMenuItem(value: "Signature", child: Text("Signature")),
    const DropdownMenuItem(value: "Pickup", child: Text("Pickup")),
  ];
  return menuItems;
}
