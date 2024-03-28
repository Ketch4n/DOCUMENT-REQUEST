import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:app/admin/add_student.dart';
import 'package:app/admin/single_update.dart';
import 'package:app/admin/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../include/navbar.dart';

import '../model/details.dart';
import '../model/user.dart';
import 'list_student.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  double screenHeight = 0;
  double screenWidth = 0;

  Future bottomsheet() async {
    showAdaptiveActionSheet(
      context: context,
      title: Text('Student LRN'),
      androidBorderRadius: 20,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text(
              'List of Student',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "NexaBold"),
            ),
            onPressed: (context) {
              Navigator.of(context).pop(false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ListStudent()),
              );
            }),
        BottomSheetAction(
            title: const Text(
              'Register Student',
              style: TextStyle(
                  fontSize: 18, color: Colors.black, fontFamily: "NexaBold"),
            ),
            onPressed: (context) {
              Navigator.of(context).pop(false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddStudent()),
              );
            }),
      ],
      cancelAction: CancelAction(
          title: const Text(
        'CANCEL',
        style: TextStyle(fontSize: 18, fontFamily: "NexaBold"),
      )), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  @override
  Widget build(BuildContext context) {
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
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            bottomsheet();
          },
          child: Icon(Icons.add),
        ),
        drawer: const NavbarScreen(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(User_details.user_name),
          backgroundColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                    "Requesting Now",
                    style: TextStyle(fontFamily: "NexaBold"),
                  ))),
              Container(
                margin: const EdgeInsets.all(10.0),
                width: double.infinity,
                height: 570,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Student')
                      .where('request', isEqualTo: "true")
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
                                  User_details.user_id = snap[index]['id'];
                                  Request_details.studentNAME =
                                      snap[index]['name'];
                                  Request_details.studentROLE =
                                      snap[index]['role'];
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SingleUpdateScreen(),
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
                                        color: Colors.blue,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        child: Image.asset(
                                          'assets/img/logo.png',
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(snap[index]['id'],
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontFamily: "NexaBold")),
                                          Text(snap[index]['role'],
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
                                          Text(snap[index]['name'],
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 15,
                                                  fontFamily: "NexaBold")),
                                          Text("(NAME)",
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
        // body: StreamBuilder<List<User3>>(
        //   stream: readUsers(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Text('Something went wrong ${snapshot.error}');
        //     } else if (snapshot.hasData) {
        //       final users = snapshot.data!;
        //       return ListView(
        //         children: users.map(buildUser).toList(),
        //       );
        //     } else {
        //       return const Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
      ),
    );
  }

  // Widget buildUser(User3 user) => Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Container(
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black26,
  //               blurRadius: 10,
  //               offset: Offset(2, 2),
  //             ),
  //           ],
  //           borderRadius: const BorderRadius.all(Radius.circular(10)),
  //         ),
  //         child: ListTile(
  //           leading: Container(
  //             width: 60,
  //             height: 60,
  //             margin: const EdgeInsets.all(0),
  //             decoration: BoxDecoration(
  //               color: (user.status == "Pending") ? Colors.blue : Colors.green,
  //               borderRadius: const BorderRadius.all(Radius.circular(5)),
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 const Center(
  //                   child:
  //                       Text("Copies", style: TextStyle(color: Colors.white)),
  //                 ),
  //                 Text(user.copies,
  //                     style: const TextStyle(color: Colors.white)),
  //               ],
  //             ),
  //           ),
  //           title: Row(
  //             children: [
  //               Text(user.name),
  //               Text("---"),
  //               Text(
  //                 user.status,
  //                 style: TextStyle(
  //                     color: (user.status == "Pending"
  //                         ? Colors.blue
  //                         : Colors.green)),
  //               ),
  //             ],
  //           ),
  //           subtitle: Row(
  //             children: [
  //               Text(user.year),
  //               Text("---"),
  //               Text(user.id),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );

  // Stream<List<User3>> readUsers() => FirebaseFirestore.instance
  //     .collection('Record')
  //     .where('status', isEqualTo: "Pending")
  //     .snapshots()
  //     .map((snapshot) =>
  //         snapshot.docs.map((doc) => User3.fromJson(doc.data())).toList());
}
