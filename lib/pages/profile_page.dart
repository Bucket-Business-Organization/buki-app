import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String email;

  ProfilePage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: Center(
        child: Text('이곳은 마이페이지입니다, $email'),
      ),
    );
  }
}
