class Reservation{
  String _userId;
  String? _bookingId;
  DateTime _bookingDate;

  Reservation({
    required String userId,
    String? bookingId,
    required DateTime bookingDate,
  })  : _userId = userId,
        _bookingId = bookingId,
        _bookingDate = bookingDate;

  // JSON을 Dart 객체로 변환하는 팩토리 메서드
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      userId: json['userId'],
      bookingId: json['bookingId'],
      bookingDate: DateTime.parse(json['bookingDate']),
    );
  }

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'bookingId': _bookingId,
      'bookingDate': _bookingDate.toIso8601String(),
    };
  }

  DateTime get bookingDate => _bookingDate;

  set bookingDate(DateTime value) {
    _bookingDate = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }


}