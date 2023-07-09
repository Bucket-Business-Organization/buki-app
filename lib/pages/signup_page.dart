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
  final TextEditingController _emailAuthCodeController =
      TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final AuthService _authService =
      AuthService(baseUrl: dotenv.env['BASE_URL'] ?? '');

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _emailAuthCodeFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  bool _emailAuthCodeVisible = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _nicknameVisible = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_updateButtonState);
    _emailAuthCodeController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
    _confirmPasswordController.addListener(_updateButtonState);
    _nicknameController.addListener(_updateButtonState);

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus && _emailController.text.isNotEmpty) {
        setState(() {
          _emailAuthCodeVisible = true;
        });
      }
    });

    _emailAuthCodeFocusNode.addListener(() {
      if (!_emailAuthCodeFocusNode.hasFocus &&
          _emailAuthCodeController.text.isNotEmpty) {
        setState(() {
          _passwordVisible = true;
        });
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus && _passwordController.text.isNotEmpty) {
        setState(() {
          _confirmPasswordVisible = true;
        });
      }
    });

    _confirmPasswordFocusNode.addListener(() {
      if (!_confirmPasswordFocusNode.hasFocus &&
          _confirmPasswordController.text.isNotEmpty) {
        setState(() {
          _nicknameVisible = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateButtonState);
    _emailAuthCodeController.removeListener(_updateButtonState);
    _passwordController.removeListener(_updateButtonState);
    _confirmPasswordController.removeListener(_updateButtonState);
    _nicknameController.removeListener(_updateButtonState);

    _emailFocusNode.dispose();
    _emailAuthCodeFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _emailAuthCodeController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _nicknameController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.only(top: 65, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 65, bottom: 56, right: 300),
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AnimatedContainer(
                height: _nicknameVisible ? 60.0 : 0.0,
                margin: _nicknameVisible
                    ? EdgeInsets.only(bottom: 40.0)
                    : EdgeInsets.only(bottom: 0.0),
                duration: Duration(milliseconds: 300),
                child: Visibility(
                  visible: _nicknameVisible,
                  child: TextField(
                    controller: _nicknameController,
                    decoration: InputDecoration(
                      labelText: '닉네임',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C23),
                      ),
                      hintText: '어떻게 불러 드릴까요?',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF191C23)),
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedContainer(
                height: _confirmPasswordVisible ? 60.0 : 0.0,
                margin: _confirmPasswordVisible
                    ? EdgeInsets.only(bottom: 40.0)
                    : EdgeInsets.only(bottom: 0.0),
                duration: Duration(milliseconds: 300),
                child: Visibility(
                  visible: _confirmPasswordVisible,
                  child: TextField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: '비밀번호 확인',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C23),
                      ),
                      hintText: '비밀번호를 한 번 더 확인 할게요.',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF191C23)),
                      ),
                    ),
                    obscureText: true,
                    focusNode: _confirmPasswordFocusNode,
                  ),
                ),
              ),
              AnimatedContainer(
                height: _passwordVisible ? 60.0 : 0.0,
                margin: _passwordVisible
                    ? EdgeInsets.only(bottom: 40.0)
                    : EdgeInsets.only(bottom: 0.0),
                duration: Duration(milliseconds: 300),
                child: Visibility(
                  visible: _passwordVisible,
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C23),
                      ),
                      hintText: '영문, 숫자를 조합해 주세요. (6자 이상)',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF191C23)),
                      ),
                    ),
                    obscureText: true,
                    focusNode: _passwordFocusNode,
                  ),
                ),
              ),
              AnimatedContainer(
                height: _emailAuthCodeVisible ? 60.0 : 0.0,
                margin: _emailAuthCodeVisible
                    ? EdgeInsets.only(bottom: 40.0)
                    : EdgeInsets.only(bottom: 0.0),
                duration: Duration(milliseconds: 300),
                child: Visibility(
                  visible: _emailAuthCodeVisible,
                  child: TextField(
                    controller: _emailAuthCodeController,
                    decoration: InputDecoration(
                      labelText: '인증번호',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C23),
                      ),
                      hintText: '인증번호를 입력해 주세요.',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF191C23)),
                      ),
                    ),
                    obscureText: true,
                    focusNode: _emailAuthCodeFocusNode,
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '이메일',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF191C23),
                  ),
                  hintText: '이메일을 입력해주세요',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF191C23)),
                  ),
                ),
                focusNode: _emailFocusNode,
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(bottom: 40.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.0),
                    backgroundColor: _isButtonEnabled
                        ? Color(0xFF00C795)
                        : Color(0xFFE7F4F1),
                    foregroundColor:
                        _isButtonEnabled ? Colors.white : Color(0xFFAAAAB0),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Set button radius
                    ),
                  ),
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
              ),
            ],
          ),
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
