import 'package:flutter/material.dart';
import 'checkPage.dart'; // CheckPage를 임포트하세요.
import 'models/reservation.dart';
import 'services/reservation_api.dart';  // ReservationApi import
import 'global/global.dart';

class ReservationConfirmationPage extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final String selectedPeriod;

  ReservationConfirmationPage({
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedPeriod,
  });

  @override
  _ReservationConfirmationPageState createState() => _ReservationConfirmationPageState();
}

class _ReservationConfirmationPageState extends State<ReservationConfirmationPage> {
  // ReservationApi 인스턴스 생성
  final ReservationApi reservationApi = ReservationApi();

  // 예약 날짜와 시간 파싱
  DateTime _parseDateTime(String date, String time) {
    try {
      // 월과 일을 추출 (예: "12월 25일")
      final dateParts = date.split('월');
      if (dateParts.length != 2) {
        throw FormatException('Invalid date format');
      }
      int month = int.parse(dateParts[0].trim());
      int day = int.parse(dateParts[1].replaceAll('일', '').trim());

      // 오전/오후 처리
      bool isMorning = time.contains('오전');
      final timeParts = time.replaceAll(RegExp(r'[오전|오후\s]'), '').split('시');
      if (timeParts.length != 2) {
        throw FormatException('Invalid time format');
      }
      int hour = int.parse(timeParts[0].trim());

      if (!isMorning && hour != 12) {
        hour += 12; // 오후이고 12시가 아닐 경우 12를 더함
      } else if (isMorning && hour == 12) {
        hour = 0; // 오전 12시는 0시로 변환
      }

      // 현재 연도를 사용하여 DateTime 객체 생성
      int year = DateTime.now().year;
      DateTime parsedDate = DateTime(year, month, day, hour, 0, 0);

      // 디버깅: 파싱된 DateTime을 출력하여 확인
      print("파싱된 DateTime: $parsedDate");

      return parsedDate;
    } catch (e) {
      print("날짜 파싱 오류: $e");
      rethrow; // 예외를 다시 던져서 호출한 곳에서 처리할 수 있게 함
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // `selectedPeriod`와 `selectedTime`을 조합하여 최종 예약 시간 생성
    final String formattedTime = '${widget.selectedPeriod} ${widget.selectedTime}';


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
                          size: screenWidth * 0.08, // 뒤로가기 아이콘 크기
                        ),
                        onPressed: () {
                          Navigator.pop(context); // 뒤로가기 동작
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
              '예약 정보를\n확인하세요',
              style: TextStyle(
                fontSize: screenWidth * 0.09,
                fontWeight: FontWeight.bold,
                color: Color(0xFF265A5A),
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            _buildInfoRow('예약 날짜', widget.selectedDate, screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.025),
            _buildInfoRow('예약 시간', formattedTime, screenWidth, screenHeight),
            // 수정된 부분
            SizedBox(height: screenHeight * 0.025),
            _buildInfoRow('운동 시간', '1시간', screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.25),
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  // CheckPage로 이동
                  print('selectedDate: ${widget.selectedDate}');
                  print('selectedTime: ${widget.selectedTime}');
                  print('selectedPeriod: ${widget.selectedPeriod}');
                  print('formattedTime: $formattedTime');

                  try {
                    // globalUserId가 null인지 확인
                    if (globalUserId == null) {
                      // globalUserId가 null인 경우 사용자에게 알림을 주고 종료
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('사용자 ID가 설정되지 않았습니다. 로그인 후 다시 시도해주세요.')),
                      );
                      return; // 종료
                    }
                    // DateTime 파싱
                    DateTime bookingDate = _parseDateTime(widget.selectedDate, formattedTime);

                    // Reservation 객체 생성
                    final reservation = Reservation(
                      userId: globalUserId!, // 전역 변수에서 userId 가져오기
                      bookingDate: bookingDate,
                      // 예: userId, facilityId 등
                    );

                    // API 호출
                    final statusCode = await reservationApi.addReservation(reservation);

                    // 상태 코드에 따른 처리
                    if (statusCode == 200 || statusCode == 201) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckPage(
                          ),
                        ),
                      );
                    } else {
                      // 에러 처리
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('예약에 실패했습니다. 상태 코드: $statusCode')),
                      );
                    }
                  } catch (e) {
                    // 예외 처리
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('예약 중 오류가 발생했습니다: $e')),
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
                  '예약하기',
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
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

  Widget _buildInfoRow(String title, String value, double screenWidth,
      double screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold,
            color: Color(0xFF265A5A),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
