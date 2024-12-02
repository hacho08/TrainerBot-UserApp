import 'package:flutter/material.dart';
import 'global/global.dart';
import 'login_check.dart';
import 'services/user_api.dart';
import 'models/user.dart';
import 'main_choice.dart';

class LoginPhoneNumberPage extends StatefulWidget {
  @override
  _LoginPhoneNumberPageState createState() => _LoginPhoneNumberPageState();
}

class _LoginPhoneNumberPageState extends State<LoginPhoneNumberPage> {
  String input = ''; // 입력된 값 저장
  final UserApi userApi = UserApi();  // UserApi 인스턴스 생성

  @override
  void onKeyPress(String value) {
    setState(() {
      if (value == '지움') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1); // 마지막 문자 삭제
        }
      } else if (value == '확인') {
        // 확인 버튼 눌렀을 때의 동작
        if (input.isNotEmpty && input.length == 11) {
          print('Input meets criteria, fetching user info...');
          _fetchUserInfo(input); // 사용자 정보 조회
          print('Input meets criteria, fetching user infddo...');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('잘 입력되었는지 확인해주세요',
                  style: TextStyle(
                      fontSize: 40,
                      fontFamily: "PaperlogySemiBold")
              ),
              ));
        }
      } else {
        if (input.length < 11) {
          input += value; // 숫자 추가
        }
      }
    });
  }

  Future<void> _fetchUserInfo(String phoneNumber) async {
    try {
      print('Fetching user info for phone number: $phoneNumber');
      User user = await userApi.getUserById(phoneNumber); // 서버에서 사용자 정보 조회
      print('User retrieved: ${user.toJson()}'); // user 객체 확인

      // 글로벌 userId 저장
      globalUserId = user.userId;  // 여기서 globalUserId 설정

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginCheckPage(user: user), // 조회된 사용자 정보를 전달
        ),
      );
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '사용자를 찾을 수 없습니다.',
            style: TextStyle(fontSize: 30),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: height * 0.04),
          // 상단 텍스트
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),

            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: height*0.03),
                  Text(
                    '전화번호를\n입력하세요',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width*0.12,
                      fontFamily: "PaperlogySemiBold",
                      color: Color(0xFF265A5A),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          // 입력된 값 표시
          Center(
            child: Text(
              input.isEmpty ? '전화번호 입력' : input,
              style: TextStyle(
                fontSize: width*0.12,
                color: input.isEmpty ? Colors.grey : Colors.black,
                fontFamily: "PaperlogySemiBold",
              ),
            ),
          ),
          Spacer(),
          // Flexible(
          //   child: Container(),  // 여유 공간을 자동으로 채움
          // ),
          // 커스텀 키패드
          Container(
            height: height * 0.6, // 키패드 영역 크기
            color: Color(0xFF265A5A),
            padding: EdgeInsets.all(5),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3열
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1.6, // 정사각형 버튼
              ),
              itemCount: 12, // 0~9 + 지움 + 확인
              itemBuilder: (context, index) {
                final List<String> keys = [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                  '6',
                  '7',
                  '8',
                  '9',
                  '지움',
                  '0',
                  '확인'
                ];
                return buildKey(keys[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildKey(String key) {
    return GestureDetector(
      onTap: () => onKeyPress(key),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(0xFF265A5A),// 버튼 색상
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          key,
          style: TextStyle(
            fontSize: 55,
            fontFamily: "PaperlogySemiBold",
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String phoneNumber; // 전달된 전화번호

  NextPage({required this.phoneNumber}); // 생성자에서 전화번호 받기

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next Page"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          '입력된 전화번호: $phoneNumber', // 전달된 전화번호 표시
          style: TextStyle(
            fontSize: 30,
            fontFamily: "PaperlogySemiBold",
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
