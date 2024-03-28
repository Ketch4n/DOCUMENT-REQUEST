import 'package:app/admin/update.dart';
import 'package:app/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/details.dart';

class SingleUpdateScreen extends StatefulWidget {
  const SingleUpdateScreen({super.key});

  @override
  State<SingleUpdateScreen> createState() => _SingleUpdateScreenState();
}

class _SingleUpdateScreenState extends State<SingleUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Status'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
              margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
              width: double.infinity,
              height: 70,
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
                mainAxisAlignment: MainAxisAlignment
                    .center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Request_details.studentNAME,
                    style: TextStyle(fontFamily: "NexaBold", fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("LRN : ${User_details.user_id}",
                      style: TextStyle(fontFamily: "NexaRegular", fontSize: 15))
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              width: double.infinity,
              height: 450,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Student')
                    .doc(User_details.user_id)
                    .collection('Request')
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
                                // User_details.user_id = snap[index]['id'];
                                Request_details.docID = snapshot
                                    .data!.docs[index].reference.id
                                    .toString();
                                Request_details.student_id =
                                    snap[index]['student_id'];
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
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const UpdateScreen(),
                                ),
                              );
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
                                      color: (snap[index]['status'] == "Pending"
                                          ? Colors.blue
                                          : Colors.green),
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
                                        Text(snap[index]['document_name'],
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontFamily: "NexaBold")),
                                        Text(snap[index]['year_level'],
                                            style: const TextStyle(
                                                color: Colors.black54)),
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
                                        Text(snap[index]['status'],
                                            style: TextStyle(
                                                color: (snap[index]['status'] ==
                                                        "Pending"
                                                    ? Colors.blue
                                                    : Colors.green),
                                                fontSize: 15,
                                                fontFamily: "NexaBold")),
                                        Text(snap[index]['date'],
                                            style: const TextStyle(
                                                color: Colors.black54)),
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
    );
  }
}
