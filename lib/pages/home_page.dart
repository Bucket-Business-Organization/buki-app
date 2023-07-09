import 'package:flutter/material.dart';

import 'profile_page.dart';
import 'group_page.dart';

class HomePage extends StatelessWidget {
  final String email;

  HomePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('환영합니다, $email!'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(email: email)),
                );
              },
              child: Text('마이페이지'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GroupPage(email: email)),
                );
              },
              child: Text('그룹 페이지'),
            ),
          ],
        ),
      ),
    );
  }
}
