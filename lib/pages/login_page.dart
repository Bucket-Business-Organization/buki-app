import 'package:flutter/material.dart';
import 'package:buki_app/services/auth_service.dart';
import 'package:buki_app/pages/home_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService(baseUrl: dotenv.env['BASE_URL'] ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
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
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              child: Text('로그인'),
              onPressed: () async {
                final email = _emailController.text;
                // final password = int.tryParse(_passwordController.text) ?? 0;
                final password = _passwordController.text;

                try {
                  final response = await _authService.login(email, password);
                  if (response['isSuccess']) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(email: email),
                      ),
                    );
                  } else {
                    print('Failed to login');
                  }
                } catch (e) {
                  print('Failed to login: $e');
                }
              },
            ),
            TextButton(
              child: Text('회원가입'),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
            ),
          ],
        ),
      ),
    );
  }
}
