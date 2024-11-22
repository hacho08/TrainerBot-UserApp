import 'package:flutter/material.dart';
import 'checkPage.dart'; // CheckPage를 임포트하세요.

class ReservationConfirmationPage extends StatelessWidget {
  final String selectedDate;
  final String selectedTime;
  final String selectedPeriod;

  ReservationConfirmationPage({
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedPeriod,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // `selectedPeriod`와 `selectedTime`을 조합하여 최종 예약 시간 생성
    final String formattedTime = '$selectedPeriod $selectedTime';

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.11), // AppBar 높이 설정
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false, // 기본 leading 제거
          flexibleSpace: SafeArea(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.teal[800],
                          size: screenWidth * 0.07, // 뒤로가기 아이콘 크기
                        ),
                        onPressed: () {
                          Navigator.pop(context); // 뒤로가기 동작
                        },
                      ),
                      Text(
                        '뒤로 가기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035, // 텍스트 크기 조정
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[800],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '예약 정보를\n확인하세요',
              style: TextStyle(
                fontSize: screenWidth * 0.09,
                fontWeight: FontWeight.bold,
                color: Color(0xFF265A5A),
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            _buildInfoRow('예약 날짜', selectedDate, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.02),
            _buildInfoRow('예약 시간', formattedTime, screenWidth, screenHeight), // 수정된 부분
            SizedBox(height: screenHeight * 0.02),
            _buildInfoRow('운동 시간', '1시간', screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.25),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // CheckPage로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[800],
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.2,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: Text(
                  '예약하기',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      String title, String value, double screenWidth, double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
