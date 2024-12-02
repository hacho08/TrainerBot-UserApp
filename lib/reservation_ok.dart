import 'package:dxpr/services/user_api.dart';
import 'package:flutter/material.dart';
import 'models/reservation.dart';
import 'services/reservation_api.dart';
import 'global/global.dart';

class ReservationConfirmationPage extends StatefulWidget {
  @override
  _ReservationConfirmationPageState createState() =>
      _ReservationConfirmationPageState();
}

class _ReservationConfirmationPageState
    extends State<ReservationConfirmationPage> {
  final ReservationApi reservationApi = ReservationApi();
  final UserApi userApi = UserApi();  // UserApi 추가
  List<Map<String, String>> reservations = [];
  bool isLoading = true;
  String userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserNameAndReservations();  // 함께 로드
    _loadReservations();
  }

  Future<void> _loadUserNameAndReservations() async {
    try {
      if (globalUserId != null) {
        // 각각 따로 호출하여 타입 안전성 확보
        final String name = await userApi.getUserName(globalUserId!);
        final List<Map<String, String>> fetchedReservations =
        await reservationApi.getUserReservations(globalUserId!);

        setState(() {
          userName = name;
          reservations = fetchedReservations;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading data: $e');
      setState(() {
        userName = 'Unknown';
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('데이터를 불러오는데 실패했습니다.')),
      );
    }
  }


  Future<void> _loadReservations() async {
    try {
      if (globalUserId != null) {
        final fetchedReservations = await reservationApi.getUserReservations(globalUserId!);
        setState(() {
          reservations = fetchedReservations;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading reservations: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('예약 목록을 불러오는데 실패했습니다.')),
      );
    }
  }

  void _removeReservation(Map<String, String> reservation) async {
    try {
      String? bookingId = reservation['id'];  // reservation에서 id 가져오기
      if (bookingId != null) {
        bool success = await reservationApi.deleteReservation(bookingId);
        if (success) {
          setState(() {
            reservations.removeWhere((item) => item['id'] == bookingId);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('예약이 취소되었습니다.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('예약 취소에 실패했습니다.')),
          );
        }
      }
    } catch (e) {
      print('Error removing reservation: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('예약 취소 중 오류가 발생했습니다.')),
      );
    }
  }

  void _showCancelDialog(BuildContext context, Map<String, String> reservation) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: screenWidth * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.05,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${reservation['date']} 예약을 \n취소하시나요?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.02,
                        ),
                      ),
                      onPressed: () {
                        _removeReservation(reservation);
                        Navigator.pop(context);
                      },
                      child: Text(
                        '예',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF979797),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.02,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '아니오',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReservationItem(BuildContext context,
      {required int index, required Map<String, String> reservation}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: screenWidth * 0.05,
            backgroundColor: Colors.teal[800],
            child: Text(
              '$index',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reservation['date'] ?? '',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  reservation['time'] ?? '',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _showCancelDialog(context, reservation);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: screenWidth * 0.08,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.11),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
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
                          size: screenWidth * 0.08,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        '뒤로 가기',
                        style: TextStyle(
                          fontSize: screenWidth * 0.03,
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
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${userName}님의 \n예약 내역입니다',
              style: TextStyle(
                fontSize: screenWidth * 0.09,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : reservations.isEmpty
                  ? Center(
                child: Text(
                  '예약 내역이 없습니다.',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.grey,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  return Column(
                    children: [
                      _buildReservationItem(
                        context,
                        index: index + 1,
                        reservation: reservation,
                      ),
                      SizedBox(height: screenHeight * 0.05),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF265A5A),
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.35,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                child: Text(
                  '나가기',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}