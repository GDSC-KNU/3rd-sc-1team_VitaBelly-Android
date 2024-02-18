import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitaBelly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color welcomeTextColor = Color(0xFFDA9D51);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  top: 20.0,
                  right: 16.0,
                  bottom: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/vitabelly_logo.png',
                      height: 100,
                      width: 100,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: '환영합니다!',
                                style: TextStyle(color: welcomeTextColor)),
                            TextSpan(
                                text:
                                    '\nVitaBelly에서는 임산부의 건강한 임신 여정을 위한 종합적인 정보를 제공합니다.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              MainScreenButton(
                text: '임신 관련 정보',
                imagePath: 'assets/vitabelly_main_button1.png',
                onPressed: () {
                  Navigator.pushNamed(context, '/pregnancyInfo');
                },
                icon: Icons.pregnant_woman,
              ),
              MainScreenButton(
                text: '산부인과 위치 정보',
                imagePath: 'assets/vitabelly_main_button2.png',
                onPressed: () {
                  Navigator.pushNamed(context, '/gynecologyClinicLocation');
                },
                icon: Icons.location_on,
              ),
              MainScreenButton(
                text: '가사 도우미 서비스',
                imagePath: 'assets/vitabelly_main_button3.png',
                onPressed: () {
                  // TODO: Navigate to the housekeeping services screen
                },
                icon: Icons.cleaning_services,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreenButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final String imagePath;

  const MainScreenButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.icon,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: BorderSide(color: Colors.grey.shade300),
          minimumSize: Size(double.infinity, 60),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
