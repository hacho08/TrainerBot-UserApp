import 'dart:convert';
import 'package:http/http.dart' as http;
import '../global/global.dart';
import '../models/reservation.dart';

class ReservationApi{
  static const String baseUrl = "http://192.168.0.32:8090/api";

  // 예약 추가
  Future<int> addReservation(Reservation reservation) async {
    final url = Uri.parse('$baseUrl/reservations'); // API 엔드포인트
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(reservation.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Reservation added successfully');
    } else {
      throw Exception('Failed to add reservation: ${response.body}');
    }
    print(response.statusCode);
    return response.statusCode;
  }

  // // 예약 조회
  // Future<int> getReservation(Reservation reservation) async {
  //   final url = Uri.parse('$baseUrl/getReservations'); // API 엔드포인트
  //   final response = await http.post(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //     body: json.encode(reservation.toJson()),
  //   );
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print('Reservation added successfully');
  //   } else {
  //     throw Exception('Failed to add reservation: ${response.body}');
  //   }
  //
  //   return response.statusCode;
  // }

  // // 예약 삭제
  // Future<void> deleteReservation(String bookingId) async {
  //   final url = Uri.parse('$baseUrl/deleteReservations'); // API 엔드포인트
  //   final response = await http.delete(
  //     url,
  //     headers: {'Content-Type': 'application/json'},
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('Reservation deleted successfully');
  //   } else {
  //     throw Exception('Failed to delete reservation: ${response.body}');
  //   }
  // }

  // 사용자별 예약 조회
  Future<List<Map<String, String>>> getUserReservations(String userId) async {
    final url = Uri.parse('$baseUrl/getReservations');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        List<dynamic> responseData = json.decode(response.body);

        List<Map<String, String>> reservations = responseData.map<Map<String, String>>((reservation) {
          DateTime bookingDate = DateTime.parse(reservation['bookingDate']);
          String bookingId = reservation['bookingId'].toString(); // 예약 ID 저장

          return {
            'id': bookingId,
            'date': _formatDate(bookingDate),
            'time': _formatTime(bookingDate),
          };
        }).toList();

        return reservations;
      } else {
        throw Exception('Failed to fetch reservations: ${response.body}');
      }
    } catch (e) {
      print('Error fetching reservations: $e');
      return [];
    }
  }

  // 예약 삭제
  Future<bool> deleteReservation(String bookingId) async {
    final url = Uri.parse('$baseUrl/deleteReservations');
    try {
      print('Deleting booking with ID: $bookingId'); // 디버깅용

      final response = await http.delete(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': bookingId}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Delete failed: ${response.body}'); // 디버깅용
        return false;
      }
    } catch (e) {
      print('Delete error: $e'); // 디버깅용
      return false;
    }
  }


  // 날짜 포맷팅 헬퍼 메서드
  String _formatDate(DateTime date) {
    const days = ['월', '화', '수', '목', '금', '토', '일'];
    String dayOfWeek = days[date.weekday - 1];
    return '${date.month}월 ${date.day}일 ${dayOfWeek}요일';
  }

  // 시간 포맷팅 헬퍼 메서드
  String _formatTime(DateTime date) {
    String period = date.hour < 12 ? '오전' : '오후';
    int hour = date.hour > 12 ? date.hour - 12 : date.hour;
    return '$period $hour시';
  }
}

