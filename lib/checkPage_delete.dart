import 'package:flutter/material.dart';
import 'main_choice.dart';
import 'reservation_ok.dart';

class CheckPageDelete extends StatelessWidget {
  final String date;

  CheckPageDelete({required this.date});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // build 메서드 내부에서 선언
    // 2초 후에 메인 화면으로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReservationConfirmationPage(), // 메인 화면으로 이동
        ),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 메인 로그인 페이지 배경색
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar 배경색
        elevation: 0, // 그림자 제거
        actions: [
          IconButton(
            icon: Image.asset('images/next.png'), // 버튼 이미지 경로 설정
            iconSize: 40, // 이미지 크기 설정
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservationConfirmationPage(), // 이동할 페이지로 설정
                ),
              );
            },
          ),
        ],
      ),
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
              '$date 예약이 \n취소되었습니다',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.09,
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
