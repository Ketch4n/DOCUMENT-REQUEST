import 'dart:async';

import 'package:flutter/material.dart';

import '../documents/request.dart';
import '../model/docu.dart';
import '../model/user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future request() async {
    await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Request ${Docu_type.docu}?",
              style:
                  const TextStyle(color: Colors.black, fontFamily: "NexaBold"),
            ),
            content: const Text(
              'NOTE : Prepare 2 pesos for each copy',
              style: TextStyle(color: Colors.red, fontFamily: "NexaRegular"),
            ),
            actions: <Widget>[
              TextButton(
                  child:
                      const Text('Okay', style: TextStyle(color: Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RequestScreen()),
                    );
                  })
            ],
          );
        });

    // return value == true;
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
        appBar: AppBar(
          centerTitle: true,
          title: Text("Dashboard"),
          backgroundColor: Colors.green,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(40),
                  width: double.infinity,
                  height: 270,
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
                        padding: const EdgeInsets.only(top: 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(300.0),
                                color: Colors.blueAccent),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.asset(
                                  'assets/img/logo.png',
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          User_details.user_name,
                          style: const TextStyle(
                              fontSize: 17, fontFamily: "NexaBold"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "LRN : ${User_details.user_id}",
                          style: const TextStyle(
                              fontSize: 17, fontFamily: "NexaRegular"),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Docu_type.docu = "COR";
                          Docu_type.document = "Certificate of Registration";
                        });
                        request();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 40, right: 10, bottom: 20),
                        width: 130,
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
                        child: const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "COR",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Docu_type.docu = "Report Card";
                          Docu_type.document = "Report Card";
                        });
                        request();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 40, bottom: 20),
                        width: 130,
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
                        child: const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Report Card",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Docu_type.docu = "NCAE";
                          Docu_type.document = "NCAE Result";
                        });
                        request();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 40, right: 10, bottom: 20),
                        width: 130,
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
                        child: const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "NCAE Result",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Docu_type.docu = "Good Moral";
                          Docu_type.document = "Good Moral";
                        });
                        request();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20),
                        width: 130,
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
                        child: const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Good Moral",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Docu_type.docu = "Form 137";
                          Docu_type.document = "Form 137";
                        });
                        request();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 40, right: 10, bottom: 20),
                        width: 130,
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
                        child: const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Form 137",
                              style: TextStyle(
                                  fontSize: 15, fontFamily: "NexaBold"),
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
      ),
    );
  }
}
