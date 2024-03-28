import 'package:flutter/material.dart';
import '../model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Future logout() async {
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Confirm Log out ?",
              style: TextStyle(color: Colors.black, fontFamily: "NexaBold"),
            ),
            content: const Text(
              'NOTE : You will be required to login again next time',
              style: TextStyle(color: Colors.red, fontFamily: "NexaRegular"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
              width: double.infinity,
              height: 130,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                'assets/img/mobod.png',
                width: screenWidth / 2,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 40, right: 40),
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
                      style:
                          const TextStyle(fontSize: 17, fontFamily: "NexaBold"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "LRN : ${User_details.user_id}",
                      style: const TextStyle(
                          fontSize: 17, fontFamily: "NexaRegular"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "(${User_details.user_role})",
                      style: const TextStyle(
                          fontSize: 17, fontFamily: "NexaRegular"),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                logout();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, left: 40, right: 40),
                width: double.infinity,
                height: 60,
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 90),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Log-out',
                        style:
                            TextStyle(fontFamily: "NexaRegular", fontSize: 17),
                      ),
                      const IconButton(
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.black54,
                        ),
                        onPressed: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
