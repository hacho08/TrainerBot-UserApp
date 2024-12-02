import 'package:flutter/material.dart';
import 'main_choice.dart';
import 'models/user.dart';

class LoginCheckPage extends StatefulWidget {
  final User user;

  LoginCheckPage({required this.user});

  @override
  _LoginCheckPageState createState() => _LoginCheckPageState();
}

class _LoginCheckPageState extends State<LoginCheckPage>{

  @override
  Widget build(BuildContext context) {
    // 2초 후 main_login.dart로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TrainerApp()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/check.png", width: 150),
            const SizedBox(height: 50),
            Text(
              '로그인이\n완료되었습니다', // 전달된 운동 강도 텍스트를 사용
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 55,
                fontFamily: "PaperlogySemiBold",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
