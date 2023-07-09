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
  final AuthService _authService =
      AuthService(baseUrl: dotenv.env['BASE_URL'] ?? '');
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 115.0, bottom: 43.0),
                child: Align(
                  alignment: Alignment.center,
                  child: ClipOval(
                    child: Image.network(
                      'https://image.utoimage.com/preview/cp872722/2022/12/202212008462_206.jpg',
                      fit: BoxFit.cover,
                      width: 102.0,
                      height: 102.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 40.0),
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    labelStyle: TextStyle(
                      color: Color(0xFF191C23),
                    ),
                    hintText: '이메일을 입력해 주세요',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF191C23)),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    labelStyle: TextStyle(
                      color: Color(0xFF191C23),
                    ),
                    hintText: '비밀번호를 입력해 주세요',
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF191C23)),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 48.0),
                  backgroundColor:
                      _isButtonEnabled ? Color(0xFF00C795) : Color(0xFFD9F1DF),
                  foregroundColor:
                      _isButtonEnabled ? Colors.white : Color(0xFFAAAAB0),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10.0), // Set button radius
                  ),
                ),
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
              Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 30.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Color(0xFF616165), // Set text color
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        '|',
                        style: TextStyle(color: Color(0xFFD2D2D2)),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        child: Text(
                          '이메일 찾기',
                          style: TextStyle(
                            color: Color(0xFF616165), // Set text color
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                      SizedBox(width: 20),
                      Text(
                        '|',
                        style: TextStyle(color: Color(0xFFD2D2D2)),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        child: Text(
                          '비밀번호 찾기',
                          style: TextStyle(
                            color: Color(0xFF616165), // Set text color
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ]),
              ),
              Image.asset(
                'assets/kakao_login_large_wide.png',
                width: double.infinity,
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    );
  }
}
