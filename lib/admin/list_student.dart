import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/list_user.dart';

class ListStudent extends StatefulWidget {
  const ListStudent({super.key});

  @override
  State<ListStudent> createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('List of Students'),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<List<User2>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildUser(User2 user) => ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Image.asset(
            'assets/img/logo.png',
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        title: Text(user.name),
        subtitle: Row(
          children: [
            Text(user.role),
            Text("---"),
            Text(user.id),
            Text("---"),
            Text(user.pass)
          ],
        ),
      );

  Stream<List<User2>> readUsers() => FirebaseFirestore.instance
      .collection('Student')
      .where('role', isEqualTo: 'student')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User2.fromJson(doc.data())).toList());
}
