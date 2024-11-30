import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/reservation.dart';

class ReservationApi{
  static const String baseUrl = "http://192.168.0.14:8090/api";

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

    return response.statusCode;
  }

  // 예약 조회
  Future<int> getReservation(Reservation reservation) async {
    final url = Uri.parse('$baseUrl/getReservations'); // API 엔드포인트
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

    return response.statusCode;
  }

  // 예약 삭제
  Future<void> deleteReservation(String bookingId) async {
    final url = Uri.parse('$baseUrl/deleteReservations'); // API 엔드포인트
    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Reservation deleted successfully');
    } else {
      throw Exception('Failed to delete reservation: ${response.body}');
    }
  }
}