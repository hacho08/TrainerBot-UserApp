import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'main_choice.dart';

class CheckPage extends StatefulWidget {

  const CheckPage({
    super.key,
  });

  @override
  _CheckPageState createState() => _CheckPageState(); // 상태 객체 생성
}


class _CheckPageState extends State<CheckPage> {
  // ReservationApi 객체 생성

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // 화면 크기 비례 텍스트 크기

    // 2초 후에 메인 화면으로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TrainerApp()),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 배경색
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
                fontSize: screenWidth * 0.09, // 화면 크기에 비례한 텍스트 크기
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
