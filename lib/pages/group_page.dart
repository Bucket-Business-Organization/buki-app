import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  final String email;

  GroupPage({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('그룹 페이지'),
      ),
      body: Center(
        child: Text('이곳은 그룹 페이지입니다, $email'),
      ),
    );
  }
}
