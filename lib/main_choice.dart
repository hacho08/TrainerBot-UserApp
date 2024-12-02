import 'package:dxpr/services/user_api.dart';
import 'package:flutter/material.dart';
import 'global/global.dart';
import 'reservation_date.dart';
import 'reservation_ok.dart';


class TrainerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LG 트레이너 봇',
      theme: ThemeData(
        fontFamily: "PaperlogySemiBold", // 전체 앱에서 적용할 폰트 설정
      ),
      home: TrainerHomePage(),
    );
  }
}

class TrainerHomePage extends StatefulWidget  {
  @override
  _TrainerHomePageState createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  final UserApi userApi = UserApi();
  String userName = ''; // 사용자 이름을 저장할 변수
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      if (globalUserId != null) {
        print('Loading user name for ID: $globalUserId'); // 디버깅용 로그
        final name = await userApi.getUserName(globalUserId!);
        print('Loaded user name: $name'); // 디버깅용 로그

        setState(() {
          userName = name;
          isLoading = false;
        });
      } else {
        print('globalUserId is null'); // 디버깅용 로그
        setState(() {
          userName = 'Guest';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error in _loadUserName: $e');
      setState(() {
        userName = 'Guest';
        isLoading = false;
      });
      // 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사용자 정보를 불러오는데 실패했습니다.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1), // AppBar 높이 살짝 증가
        child: Container(
          color: Color(0xFFDCE4E4), // AppBar 배경 색상
          padding: EdgeInsets.only(top: screenHeight * 0.02, left: screenWidth * 0.05), // 위와 왼쪽에 여백 추가
          alignment: Alignment.centerLeft, // 왼쪽 정렬
          child: SafeArea(
            child: Text(
              'LG 트레이너 봇',
              style: TextStyle(
                color: Colors.teal[800],
                fontSize: screenWidth * 0.08, // 비율에 맞춘 텍스트 크기
                fontWeight: FontWeight.bold, // 글자 더 진하게 설정
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02), // 왼쪽에 공백 추가
                  child: isLoading
                      ? CircularProgressIndicator() // 로딩 중일 때 표시
                      : Text(
                    '환영합니다\n${userName}님',
                    style: TextStyle(
                      fontSize: screenWidth * 0.1,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF265A5A),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.05),
                  child: Image.asset(
                    "images/main_green.png",
                    width: screenWidth * 0.4, // 이미지의 너비를 설정
                    height: screenWidth * 0.4, // 이미지의 높이를 설정
                    fit: BoxFit.contain, // 이미지 비율 유지
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.06),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildButton(
                  context,
                  text: '예약',
                  color: Color(0xFFE2E5E5),
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.2,
                  fontSize: screenWidth * 0.12,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReservationPage()),
                    );
                  },
                ),
                SizedBox(height: 60),
                _buildButton(
                  context,
                  text: '예약 확인',
                  color: Color(0xFFe2D9CC),
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.2,
                  fontSize: screenWidth * 0.12,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReservationConfirmationPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String text,
        required Color? color,
        required double width,
        required double height,
        required double fontSize,
        required VoidCallback onPressed}) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize, // 비율에 맞춘 텍스트 크기
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
