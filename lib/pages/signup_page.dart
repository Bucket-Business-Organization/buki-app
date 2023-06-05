import 'package:flutter/material.dart';
import 'package:buki_app/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(baseUrl: dotenv.env['BASE_URL'] ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '이메일',
              ),
            ),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: '닉네임',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              child: Text('회원가입'),
              onPressed: () async {
                final email = _emailController.text;
                final nickname = _nicknameController.text;
                // final password = int.tryParse(_passwordController.text) ?? 0;
                final password = _passwordController.text;

                try {
                  final response =
                      await _authService.join(email, nickname, password);
                  if (response['isSuccess']) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/login',
                    );
                  } else {
                    _showDialog(context, '회원가입에 실패했습니다.');
                  }
                } catch (e) {
                  print('Failed to sign up: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
