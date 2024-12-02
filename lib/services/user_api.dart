import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

class UserApi {
  static const String baseUrl = "http://192.168.0.14:8090/api"; // 서버 주소


  // 특정 사용자 조회
  Future<User> getUserById(String userId) async {
    print('사용자 조회: $userId');
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: {"Content-Type": "text/plain"},
      body: userId,
    ); // userId를 서버로 전송);
    print('Response status: ${response.statusCode}');

    final String responseBody = utf8.decode(response.bodyBytes);
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(
          utf8.decode(response.bodyBytes));

      // User 객체로 변환
      return User.fromJson(data);
    } else {
      throw Exception('Failed to load user with ID $userId');
    }
  }

  Future<String> getUserName(String userId) async {
    final url = Uri.parse('$baseUrl/users/getUserInfo');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8', // UTF-8 명시
        },
        body: json.encode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        final userData = json.decode(
            utf8.decode(response.bodyBytes)); // utf8.decode 사용
        String userName = userData['userName'] ?? 'Unknown';
        print('Received userName: $userName');
        return userName;
      } else {
        throw Exception('Failed to load user name');
      }
    } catch (e) {
      print('Error in getUserName: $e');
      rethrow;
    }
  }
}