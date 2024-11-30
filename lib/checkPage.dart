import 'package:flutter/material.dart';
import 'global/global.dart';
import 'main_choice.dart';
import 'models/reservation.dart';
import 'services/reservation_api.dart';  // ReservationApi import

class CheckPage extends StatefulWidget {
  const CheckPage({super.key, required this.date, required this.time});

  final String date;
  final String time;

  @override
  _CheckPageState createState() => _CheckPageState();// 상태 객체 생성
}

class _CheckPageState extends State<CheckPage> {
  // ReservationApi 객체 생성
  ReservationApi reservationApi = ReservationApi();

  // 예약 정보를 API로 호출하는 비동기 메서드
  Future<void> _callApi() async {
    try {
      // 예약 날짜와 시간을 결합하여 DateTime 객체 생성
      DateTime bookingDate = _parseDateTime(widget.date, widget.time);

      // 예약 정보 생성
      final reservation = Reservation(
        userId: globalUserId!, // 전역 변수에서 userId 가져오기
        bookingDate: bookingDate,
      );

      // 예약 API 호출
      await reservationApi.addReservation(reservation);
      print("예약이 성공적으로 저장되었습니다.");
    } catch (e) {
      print("예약 저장 실패: $e");
    }
  }

  // 예약 날짜와 시간 파싱
  DateTime _parseDateTime(String date, String time) {
    try {
      // 월과 일을 추출
      final dateParts = date.replaceAll('일', '').split('월');
      int month = int.parse(dateParts[0].trim());
      int day = int.parse(dateParts[1].trim());

      // 오전/오후 처리
      bool isMorning = time.contains('오전');
      final timeParts = time.replaceAll(RegExp(r'[오전|오후\s]'), '').split('시');
      int hour = int.parse(timeParts[0].trim());

      if (!isMorning && hour != 12) {
        hour += 12; // 오후이고 12시가 아닐 경우 12를 더함
      } else if (isMorning && hour == 12) {
        hour = 0; // 오전 12시는 0시로 변환
      }

      // 현재 연도를 사용하여 DateTime 객체 생성
      int year = DateTime.now().year;
      return DateTime(year, month, day, hour, 0, 0);
    } catch (e) {
      print("날짜 파싱 오류: $e");
      rethrow; // 예외를 다시 던져서 호출한 곳에서 처리할 수 있게 함
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width; // 화면 너비에 맞춘 비율

    // 2초 후에 메인 화면으로 이동
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TrainerHomePage(), // 메인 화면으로 이동
        ),
      );
      // 예약 API 호출 (페이지 이동 후 호출)
      _callApi();
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
