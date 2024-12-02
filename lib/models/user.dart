
class User {
  String _userId;
  String _userName;
  int _birthYear;
  String _gender;
  String _workoutExperience;
  String _goal;
  List<int> _bodyConditionIds;
  List<int> _hobby;
  DateTime _createdAt;

  // 생성자
  User({
    required String userId,
    required String userName,
    required int birthYear,
    required String gender,
    required String workoutExperience,
    required String goal,
    required List<int> bodyConditionIds,
    required List<int> hobby,
    required DateTime createdAt,
  })
      : _userId = userId,
        _userName = userName,
        _birthYear = birthYear,
        _gender = gender,
        _workoutExperience = workoutExperience,
        _goal = goal,
        _bodyConditionIds = bodyConditionIds,
        _hobby = hobby,
        _createdAt = createdAt ?? DateTime.now();

  // JSON을 Dart 객체로 변환하는 팩토리 메서드
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      userName: json['userName'],
      birthYear: json['birthYear'],
      gender: json['gender'],
      workoutExperience: json['workoutExperience'],
      goal: json['goal'],
      bodyConditionIds: List<int>.from(json['bodyConditionIds'] ?? []),
      // 리스트 처리
      hobby: List<int>.from(json['hobby'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Dart 객체를 JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'userName': _userName,
      'birthYear': _birthYear,
      'gender': _gender,
      'workoutExperience': _workoutExperience,
      'goal': _goal,
      'bodyConditionIds': _bodyConditionIds,
      'hobby': _hobby,
      'createdAt': _createdAt.toIso8601String(),
    };
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime value) {
    _createdAt = value;
  }

  List<int> get hobby => _hobby;

  set bodyConditionIds(List<int> value) {
    _bodyConditionIds = value;
  }

  List<int> get bodyConditionIds => _bodyConditionIds;

  String get goal => _goal;

  set goal(String value) {
    _goal = value;
  }

  String get workoutExperience => _workoutExperience;

  set workoutExperience(String value) {
    _workoutExperience = value;
  }

  String get gender => _gender;

  set gender(String value) {
    _gender = value;
  }

  int get birthYear => _birthYear;

  set birthYear(int value) {
    _birthYear = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  set hobby(List<int> value) {
    _hobby = value;
  }
}


