import 'package:flutter/material.dart';
import 'main_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  void _login() {
    // 로그인 로직을 검증하는 코드
    bool loginSuccess = true;

    if (loginSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      // 로그인 실패 시 처리
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Color(0xFFDA9D51);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 0),
                Image.asset(
                  'assets/vitabelly_logo.png',
                  height: 250,
                ),
                SizedBox(height: 0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: 'ID',
                      labelStyle: TextStyle(color: accentColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: accentColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: accentColor),
                      ),
                    ),
                    cursorColor: accentColor,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    controller: _pwController,
                    decoration: InputDecoration(
                      labelText: 'PW',
                      labelStyle: TextStyle(color: accentColor),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: accentColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: accentColor),
                      ),
                    ),
                    obscureText: true,
                    cursorColor: accentColor,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // password recovery
                        },
                        child: Text('비밀번호 찾기',
                            style: TextStyle(color: accentColor)),
                      ),
                      SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          // sign up
                        },
                        child:
                            Text('회원가입', style: TextStyle(color: accentColor)),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  ),
                  onPressed: _login, // 버튼 클릭 시 _login 메서드 호출
                  child: Text('로그인'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
