import 'package:app/admin/upload.dart';
import 'package:app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import '../model/file_upload.dart';
import '../model/type.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(User_details.user_name),
              accountEmail: Text("@ mobod.integrated.school"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    'assets/img/mobod.jpg',
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                // image: DecorationImage(
                //   fit: BoxFit.fill,
                //   image: NetworkImage(
                //       'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
                // ),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.home),
            //   title: Text('Homepage'),
            //   onTap: () {
            //
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (context) => const ScanScreen(),
            //       ),
            //     );
            //   },
            // ),
            ListTile(
              title: Text("Admin"),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Certificate of Enrollment'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UploadScreen(),
                  ),
                );
                setState(() {
                  Upload.filename = "COR";
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Report Card'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UploadScreen(),
                  ),
                );
                setState(() {
                  Upload.filename = "Report Card";
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Good Moral'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UploadScreen(),
                  ),
                );
                setState(() {
                  Upload.filename = "Good Moral";
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Form 137'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UploadScreen(),
                  ),
                );
                setState(() {
                  Upload.filename = "Form 137";
                });
              },
            ),
            Divider(),
            ListTile(
              title: Text('Result'),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('NCAE Result'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UploadScreen(),
                  ),
                );
                setState(() {
                  Upload.filename = "NCAE";
                });
              },
            ),

            // Divider(),
            // ListTile(
            //     title: Text('Log-out'),
            //     leading: Icon(Icons.exit_to_app),
            //     onTap: () {
            //       Navigator.of(context).pop(false);
            //       //
            //       // logout();
            //     }),
          ],
        ),
      ),
    );
  }
}
