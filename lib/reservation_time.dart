import 'package:flutter/material.dart';
import 'reservation_date.dart';
import 'reservation_confirm.dart';

class TimeReservationPage extends StatefulWidget {
  final String selectedDate;

  TimeReservationPage({required this.selectedDate});

  @override
  _TimeReservationPageState createState() => _TimeReservationPageState();
}

class _TimeReservationPageState extends State<TimeReservationPage> {
  final List<String> morningTimes = ['8:00', '9:00', '10:00', '11:00', '12:00'];
  final List<String> afternoonTimes = ['1:00', '2:00', '3:00', '4:00', '5:00'];

  String? selectedTime; // 선택된 시간
  String? selectedPeriod; // 선택된 오전/오후 구분

  void selectTime(String time, String period) {
    setState(() {
      selectedTime = time; // 선택된 시간 저장
      selectedPeriod = period; // 선택된 오전/오후 저장
    });
  }

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
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Text(
              '예약을 원하는\n시간을 선택하세요',
              style: TextStyle(
                fontSize: screenWidth * 0.09, // 텍스트 크기 줄임
                fontWeight: FontWeight.bold,
                color: Color(0xFF265A5A),
              ),
              textAlign: TextAlign.left, // 텍스트 왼쪽 정렬
            ),
            SizedBox(height: screenHeight * 0.02), // 간격 조정

            // 오전/오후 시간 리스트 및 텍스트
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 두 열 사이의 간격을 더 좁힘
              children: [
                // 오전 시간 리스트
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // 중앙 정렬
                  children: [
                    Text(
                      '오전',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // 오전 시간 버튼들
                    Column(
                      children: morningTimes
                          .map((time) =>
                          _buildTimeButton(time, '오전', screenWidth, screenHeight))
                          .toList(),
                    ),
                  ],
                ),
                // 오후 시간 리스트
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // 중앙 정렬
                  children: [
                    Text(
                      '오후',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    // 오후 시간 버튼들
                    Column(
                      children: afternoonTimes
                          .map((time) =>
                          _buildTimeButton(time, '오후', screenWidth, screenHeight))
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),

            // '다음' 버튼을 위로 올리기 위해 SizedBox로 여백 조정
            SizedBox(height: screenHeight * 0.06),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedTime != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationConfirmationPage(
                          selectedTime: selectedTime!,
                          selectedPeriod: selectedPeriod!, // 추가된 부분
                          selectedDate: widget.selectedDate,
                        ),
                      ),
                    );
                  } else {
                    // 시간 선택을 안 했을 경우 처리
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('시간을 선택해주세요!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.2,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: Text(
                  '다음',
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

  Widget _buildTimeButton(
      String time, String period, double screenWidth, double screenHeight) {
    final isSelected = selectedTime == time;

    return GestureDetector(
      onTap: () => selectTime(time, period), // 클릭 이벤트 처리
      child: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.008), // 상하 간격 조정
        width: screenWidth * 0.39, // 버튼 폭 조정
        height: screenHeight * 0.07, // 버튼 높이 줄임
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal[800] : Colors.white,
          border: Border.all(color: Colors.teal[800]!, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            time,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.045, // 버튼 텍스트 크기 조정
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.teal[800],
            ),
          ),
        ),
      ),
    );
  }
}
