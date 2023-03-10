final String tableRoles = 'roles';

class RoleFields {
  static final List<String> values = [id, name];
  static const String id = '_id';
  static const String name = 'name';
}

class Role {
  final int id;
  final String name;

  const Role({
    required this.id,
    required this.name,
  });

  static Role fromJson(Map<String, Object?> json) => Role(
      id: json['_id'] as int,
      name: json['name'] as String,
  );

}