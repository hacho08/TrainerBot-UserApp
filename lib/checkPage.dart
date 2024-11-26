import 'package:flutter/material.dart';
import 'main_choice.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // build 메서드 내부에서 선언

    // 2초 후에 메인 화면으로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TrainerHomePage(), // 메인 화면으로 이동
        ),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 메인 로그인 페이지 배경색
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/check.png",
              width: 150,
            ),
            const SizedBox(height: 50),
            Text(
              '예약되었습니다.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.09, // 비율에 맞춘 텍스트 크기
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
