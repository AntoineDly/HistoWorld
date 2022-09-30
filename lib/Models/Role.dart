final String tableRoles = 'roles';

class RoleFields {
  static final List<String> values = [
    /// Add all fields
    id, name
  ];

  static const String id = '_id';
  static const String name = 'name';
}

class Role {
  final int? id;
  final String name;

  const Role({
    this.id,
    required this.name,
  });

  Role copy({
    int? id,
    String? name,
  }) =>
      Role(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  static Role fromJson(Map<String, Object?> json) => Role(
      id: json['id'] as int?,
      name: json['name'] as String,
  );

  Map<String, Object?> toJson() {
    return {
      RoleFields.id: id,
      RoleFields.name: name,
    };
  }
}