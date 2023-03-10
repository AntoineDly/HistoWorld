final String tableNumberUsers = 'numberUsers';

class NumberUsersFields {
  static final List<String> values = [id, roleId, expected, current];
  static const String id = '_id';
  static const String roleId = 'roleId';
  static const String expected = 'expected';
  static const String current = 'current';
}

class NumberUsers {
  final int? id;
  final int roleId;
  final int expected;
  final int current;

  const NumberUsers({
    this.id,
    required this.roleId,
    required this.expected,
    required this.current,
  });

  NumberUsers copy({
    int? id,
    int? roleId,
    int? expected,
    int? current
  }) =>
      NumberUsers(
        id: id ?? this.id,
        roleId: roleId ?? this.roleId,
        expected: expected ?? this.expected,
        current: current ?? this.current,
      );

  static NumberUsers fromJson(Map<String, Object?> json) => NumberUsers(
    id: json['_id'] as int?,
    roleId: json['roleId'] as int,
    expected: json['expected'] as int,
    current: json['current'] as int
  );

  Map<String, Object?> toJson() {
    return {
      NumberUsersFields.id: id,
      NumberUsersFields.roleId: roleId,
      NumberUsersFields.expected: expected,
      NumberUsersFields.current: current,
    };
  }
}