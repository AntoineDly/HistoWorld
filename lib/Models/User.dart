final String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    /// Add all fields
    id, name, personaId
  ];

  static const String id = '_id';
  static const String name = 'name';
  static const String personaId = 'personaId';
}

class User {
  final int? id;
  final String name;
  final int personaId;

  const User({
    this.id,
    required this.name,
    required this.personaId,
  });

  User copy({
    int? id,
    String? name,
    int? personaId,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        personaId: personaId ?? this.personaId,
      );

  static User fromJson(Map<String, Object?> json) => User(
    id: json['id'] as int?,
    name: json['name'] as String,
    personaId: json['roleId'] as int,
  );

  Map<String, Object?> toJson() {
    return {
      UserFields.id: id,
      UserFields.name: name,
      UserFields.personaId: personaId,
    };
  }
}