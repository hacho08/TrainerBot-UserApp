class Reservation{
  String _userId;
  DateTime _bookingDate;

  Reservation({
    required String userId,
    required DateTime bookingDate,
  })  : _userId = userId,
        _bookingDate = bookingDate;

  // JSON을 Dart 객체로 변환하는 팩토리 메서드
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      userId: json['userId'],
      bookingDate: DateTime.parse(json['bookingDate']),
    );
  }

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
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