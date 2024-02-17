import 'package:flutter/material.dart';

void main() {
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
      home: PregnancyInfoScreen(),
    );
  }
}

class PregnancyInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color highlightedTextColor = Color(0xFFDA9D51);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('임신 관련 정보'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: '임신은 변화와 성장의 시기',
                        style: TextStyle(
                          color: highlightedTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '입니다.\n임신의 각 단계에서 필요한 정보들을\n제공하여 ',
                      ),
                      TextSpan(
                        text: '적절한 대응을 할 수 있도록 안내',
                        style: TextStyle(
                          color: highlightedTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '합니다.\n안전한 출산 준비와 건강 유지에 관한 정보들을\n지금 바로 확인하세요.',
                      ),
                    ],
                  ),
                ),
              ),
              MainScreenButton(
                text: '임신 필수 검사 일정',
                onPressed: () {
                  // TODO: Navigate to the essential pregnancy test schedule page
                },
                imagePath: 'assets/vitabelly_pregnant_button1.png',
              ),
              MainScreenButton(
                text: '임신 중 자기 관리',
                onPressed: () {
                  // TODO: Navigate to the pregnancy self-care page
                },
                imagePath: 'assets/vitabelly_pregnant_button2.png',
              ),
              MainScreenButton(
                text: '임신 중 금기 의약품',
                onPressed: () {
                  // TODO: Navigate to the contraindicated medications during pregnancy page
                },
                imagePath: 'assets/vitabelly_pregnant_button3.png',
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
  final String imagePath;

  const MainScreenButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200], // Button color
          foregroundColor: Colors.black, // Text color
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          side: BorderSide(color: Colors.grey.shade300),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: double
                  .infinity, // Makes the image take up the full width of the button
              fit: BoxFit.fitWidth, // Ensures the image scales correctly
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
