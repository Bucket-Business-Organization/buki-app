import 'package:flutter/material.dart';

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
        child: Text('환영합니다, $email!'),
      ),
    );
  }
}
