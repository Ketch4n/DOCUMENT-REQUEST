// ignore_for_file: camel_case_types, depend_on_referenced_packages

import 'package:app/model/details.dart';
import 'package:app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:intl/intl.dart';

class SentScreen extends StatefulWidget {
  const SentScreen({super.key});

  @override
  State<SentScreen> createState() => _SentScreenState();
}

class _SentScreenState extends State<SentScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Future status() async {
    await showDialog<bool>(
        context: context,
        builder: (context) {
          return Container(
            margin:
                const EdgeInsets.only(left: 20, right: 10, top: 60, bottom: 30),
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
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Request Info",
                    style: TextStyle(fontFamily: "NexaBold", fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Student ID",
                            style: TextStyle(fontFamily: "NexaBold"),
                          ),
                          Text(User_details.user_id)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Document Name",
                            style: TextStyle(fontFamily: "NexaBold"),
                          ),
                          Text(Request_details.docu_name)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Year Level",
                            style: TextStyle(fontFamily: "NexaBold"),
                          ),
                          Text(Request_details.year_level)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "No.of copies",
                            style: TextStyle(fontFamily: "NexaBold"),
                          ),
                          Text(Request_details.no_of_copies)
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Date Releasing",
                            style: TextStyle(fontFamily: "NexaBold"),
                          ),
                          Text(
                            Request_details.docu_status == "Pickup"
                                ? "TODAY"
                                : "5 working days",
                            style: TextStyle(
                              color: (Request_details.docu_status == "Pickup")
                                  ? Colors.green
                                  : Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          const Text(
                            "Status",
                            style: TextStyle(fontFamily: "NexaBold"),
                          ),
                          Text(
                            Request_details.docu_status,
                            style: TextStyle(
                              color: (Request_details.docu_status == "Pending")
                                  ? Colors.blue
                                  : Colors.green,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(20),
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
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        left: 37, right: 37, top: 20),
                                    decoration: BoxDecoration(
                                      color: (Request_details.docu_status ==
                                              "Pending")
                                          ? Colors.blue
                                          : Colors.white,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                    )),
                                Container(
                                  width: 1,
                                  height: 30,
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                ),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                      left: 37,
                                      right: 37,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (Request_details.docu_status ==
                                              "Accepted")
                                          ? Colors.green
                                          : Colors.white,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                    )),
                                Container(
                                  width: 1,
                                  height: 30,
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                ),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                      left: 37,
                                      right: 37,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (Request_details.docu_status ==
                                              "Printing")
                                          ? Colors.green
                                          : Colors.white,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                    )),
                                Container(
                                  width: 1,
                                  height: 30,
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                ),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                      left: 37,
                                      right: 37,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (Request_details.docu_status ==
                                              "Signature")
                                          ? Colors.green
                                          : Colors.white,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                    )),
                                Container(
                                  width: 1,
                                  height: 30,
                                  decoration:
                                      const BoxDecoration(color: Colors.black),
                                ),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                      left: 37,
                                      right: 37,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (Request_details.docu_status ==
                                              "Pickup")
                                          ? Colors.green
                                          : Colors.white,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      boxShadow: [
                                        const BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(2, 2),
                                        ),
                                      ],
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                    )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 37, bottom: 10),
                                    child: Text(
                                      "Pending",
                                      style: TextStyle(
                                        color: (Request_details.docu_status ==
                                                "Pending")
                                            ? Colors.blue
                                            : Colors.black,
                                      ),
                                    )),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(
                                      "Accepted",
                                      style: TextStyle(
                                        color: (Request_details.docu_status ==
                                                "Accepted")
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    )),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(
                                      "Printing",
                                      style: TextStyle(
                                        color: (Request_details.docu_status ==
                                                "Printing")
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    )),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(
                                      "Signature",
                                      style: TextStyle(
                                        color: (Request_details.docu_status ==
                                                "Signature")
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    )),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(
                                      "Pickup",
                                      style: TextStyle(
                                        color: (Request_details.docu_status ==
                                                "Pickup")
                                            ? Colors.green
                                            : Colors.black,
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 37, bottom: 10),
                                    child: Text(
                                        Request_details.docu_status == "Pending"
                                            ? Request_details.date
                                            : "")),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(Request_details.docu_status ==
                                            "Accepted"
                                        ? Request_details.date
                                        : "")),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(Request_details.docu_status ==
                                            "Printing"
                                        ? Request_details.date
                                        : "")),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(Request_details.docu_status ==
                                            "Signature"
                                        ? Request_details.date
                                        : "")),
                                Container(
                                    height: 20,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 10),
                                    child: Text(
                                        Request_details.docu_status == "Pickup"
                                            ? Request_details.date
                                            : ""))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Container(
                    height: 30,
                    width: 100,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Center(
                      child: Text(
                        "Close",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
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
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sent"),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 10),
                  width: double.infinity,
                  height: 50,
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
                  child: const Center(
                      child: Text(
                    "Requested Documents",
                    style: TextStyle(fontFamily: "NexaBold"),
                  ))),
              Container(
                margin: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 470,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Student')
                      .doc(User_details.user_id)
                      .collection('Request')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final snap = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: snap.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Request_details.student_name =
                                      snap[index]['student_name'];
                                  Request_details.docu_name =
                                      snap[index]['document_name'];
                                  Request_details.no_of_copies =
                                      snap[index]['no_of_copies'];
                                  Request_details.docu_status =
                                      snap[index]['status'];
                                  Request_details.year_level =
                                      snap[index]['year_level'];
                                  Request_details.date = snap[index]['date'];
                                });
                                status();
                              },
                              child: Container(
                                height: 70,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 20,
                                      offset: Offset(2, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                      topRight: Radius.circular(30)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            (snap[index]['status'] == "Pending")
                                                ? Colors.blue
                                                : Colors.green,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Center(
                                            child: Text("Copies",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ),
                                          Text(snap[index]['no_of_copies'],
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            snap[index]['document_name'],
                                            style: TextStyle(
                                              fontFamily: "NexaRegular",
                                              fontSize: screenWidth / 20,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            snap[index]['status'],
                                            style: TextStyle(
                                              fontFamily: "NexaRegular",
                                              fontSize: screenWidth / 20,
                                              color: (snap[index]['status'] ==
                                                      "Pending")
                                                  ? Colors.blue
                                                  : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // Text(
                                          //   snap[index]['time'],
                                          //   style: TextStyle(
                                          //     fontFamily: "NexaRegular",
                                          //     fontSize: screenWidth / 20,
                                          //     color: Colors.black54,
                                          //   ),
                                          // ),
                                          Text(
                                            snap[index]['date'],
                                            style: TextStyle(
                                              fontFamily: "NexaRegular",
                                              fontSize: screenWidth / 20,
                                              color: (snap[index]['status'] ==
                                                      "Pending")
                                                  ? Colors.blue
                                                  : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      // ignore: unrelated_type_equality_checks
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
