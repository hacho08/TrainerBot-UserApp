import 'package:dxpr/services/user_api.dart';
import 'package:flutter/material.dart';
import 'global/global.dart';
import 'reservation_date.dart';
import 'reservation_ok.dart';
import 'main.dart';  // MainApp import 추가

class TrainerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LG 트레이너 봇',
      theme: ThemeData(
        fontFamily: "PaperlogySemiBold",
      ),
      home: TrainerHomePage(),
    );
  }
}

class TrainerHomePage extends StatefulWidget {
  @override
  _TrainerHomePageState createState() => _TrainerHomePageState();
}

class _TrainerHomePageState extends State<TrainerHomePage> {
  final UserApi userApi = UserApi();
  String userName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      if (globalUserId != null) {
        print('Loading user name for ID: $globalUserId');
        final name = await userApi.getUserName(globalUserId!);
        print('Loaded user name: $name');

        setState(() {
          userName = name;
          isLoading = false;
        });
      } else {
        print('globalUserId is null');
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
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: Container(
          color: Color(0xFFDCE4E4),
          padding: EdgeInsets.only(top: screenHeight * 0.02),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.05),
                  child: Text(
                    'LG 트레이너 봇',
                    style: TextStyle(
                      color: Colors.teal[800],
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.05),
                  child: IconButton(
                    iconSize: screenWidth * 0.1,
                    icon: Icon(
                        Icons.logout,
                        color: Colors.teal[800],
                        size: screenWidth * 0.1,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                            (route) => false,
                      );
                    },
                  ),
                ),
              ],
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
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: isLoading
                      ? CircularProgressIndicator()
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
                    width: screenWidth * 0.4,
                    height: screenWidth * 0.4,
                    fit: BoxFit.contain,
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
            fontSize: fontSize,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}