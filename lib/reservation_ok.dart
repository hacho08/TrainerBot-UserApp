import 'package:flutter/material.dart';
import 'checkPage_delete.dart';

class ReservationConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '옥수수님의 \n예약 내역입니다',
              style: TextStyle(
                fontSize: screenWidth * 0.09,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Expanded(
              child: ListView(
                children: [
                  _buildReservationItem(
                    context,
                    index: 1,
                    date: '12월 4일 수요일',
                    time: '오전 7시 30분',
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  _buildReservationItem(
                    context,
                    index: 2,
                    date: '12월 5일 목요일',
                    time: '오전 9시',
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 나가기 버튼 클릭 시 이전 화면으로 이동
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[800],
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.38,
                    vertical: screenHeight * 0.02,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  '나가기',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationItem(BuildContext context,
      {required int index, required String date, required String time}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.05,
            backgroundColor: Colors.teal[800],
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$date',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '$time',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showCancelDialog(context, date); // 팝업창 호출
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: screenWidth * 0.08,
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context, String date) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.zero, // 기본 패딩 제거
          content: Container(
            width: screenWidth * 0.85, // 팝업창 너비
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1, // 좌우 패딩 추가
              vertical: screenHeight * 0.05, // 상하 패딩 추가
            ), // 팝업창 내부 여백 추가
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$date 예약을 \n취소하시나요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.06), // 텍스트와 버튼 간격
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.02,
                        ),
                      ),
                      onPressed: () {
                        print('예약 삭제됨: $date');
                        Navigator.pop(context); // 팝업 닫기
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CheckPageDelete(date: date),
                          ),
                        );
                      },
                      child: Text(
                        '예',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF979797),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.02,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context); // 팝업 닫기
                      },
                      child: Text(
                        '아니오',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
