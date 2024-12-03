import 'package:flutter/material.dart';
import 'reservation_time.dart';

class ReservationPage extends StatefulWidget {
  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final List<Map<String, String>> dates = [
    {'date': '12월 4일', 'day': '수요일'},
    {'date': '12월 5일', 'day': '목요일'},
    {'date': '12월 6일', 'day': '금요일'},
    {'date': '12월 7일', 'day': '토요일'},
    {'date': '12월 8일', 'day': '일요일'},
    {'date': '12월 9일', 'day': '월요일'},
    {'date': '12월 10일', 'day': '화요일'},
  ];

  int currentIndex = 0; // 현재 보여줄 첫 번째 날짜의 인덱스
  int? selectedIndex; // 선택된 날짜의 인덱스
  String? selectedDate; // 선택된 날짜를 저장하는 변수

  void goToNextDates() {
    setState(() {
      if (currentIndex < dates.length - 2) {
        currentIndex += 2;
      }
    });
  }

  void goToPreviousDates() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex -= 2;
      }
    });
  }

  void selectDate(int index) {
    setState(() {
      if (selectedIndex == index) {
        // 이미 선택된 날짜를 다시 누르면 선택 해제
        selectedIndex = null;
        selectedDate = null;
      } else {
        // 새로운 날짜를 선택
        selectedIndex = index;
        selectedDate = dates[index]['date'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.11), // AppBar 높이를 설정
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
                          size: screenWidth * 0.08, // 뒤로가기 아이콘 크기
                        ),
                        onPressed: () {
                          Navigator.pop(context); //  뒤로가기 동작
                        },
                      ),
                      Text(
                        '뒤로 가기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.03, // 텍스트 크기 조정
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
              '예약을 원하는\n날짜를 선택하세요',
              style: TextStyle(
                fontSize: screenWidth * 0.09, // 비율에 맞춘 텍스트 크기
                fontWeight: FontWeight.bold,
                color: Color(0xFF265A5A),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              '날짜',
              style: TextStyle(
                fontSize: screenWidth * 0.08,
                fontWeight: FontWeight.bold,
                color: Color(0xFF265A5A),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 이전 버튼
                IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    color: currentIndex > 0 ? Colors.teal[800] : Colors.grey,
                    size: screenWidth * 0.1, // 화살표 크기 키움
                  ),
                  onPressed: currentIndex > 0 ? goToPreviousDates : null,
                ),
                // 현재 2개의 날짜 카드
                Column(
                  children: [
                    if (currentIndex < dates.length)
                      _buildDateCard(
                        dates[currentIndex],
                        screenWidth,
                        screenHeight,
                        currentIndex,
                      ),
                    if (currentIndex + 1 < dates.length)
                      SizedBox(height: screenHeight * 0.04,),
                    if (currentIndex + 1 < dates.length)
                      _buildDateCard(
                        dates[currentIndex + 1],
                        screenWidth,
                        screenHeight,
                        currentIndex + 1,
                      ),
                  ],
                ),
                // 다음 버튼
                IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    color: currentIndex < dates.length - 2
                        ? Colors.teal[800]
                        : Colors.grey,
                    size: screenWidth * 0.1, // 화살표 크기 키움
                  ),
                  onPressed: currentIndex < dates.length - 2
                      ? goToNextDates
                      : null,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedDate != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TimeReservationPage(
                          selectedDate: selectedDate!,
                        ),
                      ),
                    );
                  } else {
                    // 날짜가 선택되지 않았을 경우 경고 메시지
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('날짜를 선택해주세요!',
                      style: TextStyle(
                        fontSize: 30
                      ),)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF265A5A),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.35,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: Text(
                  '다음',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
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

  Widget _buildDateCard(Map<String, String> dateInfo, double screenWidth,
      double screenHeight, int index) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => selectDate(index), // 클릭 이벤트 처리
      child: Container(
        width: screenWidth * 0.6,
        height: screenHeight * 0.18,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF265A5A): Colors.white,
          border: Border.all(color: Colors.teal[800]!, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '${dateInfo['date']}\n${dateInfo['day']}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.075,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.white : Colors.teal[800],
            ),
          ),
        ),
      ),
    );
  }
}
