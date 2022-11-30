final String tablePersonas = 'personas';

class PersonaFields {
  static final List<String> values = [id, name, roleId, isAlreadySelected];
  static const String id = '_id';
  static const String name = 'name';
  static const String roleId = 'roleId';
  static const String isAlreadySelected = 'isAlreadySelected';
}

class Persona {
  final int id;
  final String name;
  final int roleId;
  final int isAlreadySelected;

  const Persona({
    required this.id,
    required this.name,
    required this.roleId,
    required this.isAlreadySelected
  });

  Persona copy({
    int? id,
    String? name,
    int? roleId,
    int? isAlreadySelected
  }) =>
      Persona(
        id: id ?? this.id,
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        isAlreadySelected: isAlreadySelected ?? this.isAlreadySelected
      );

  static Persona fromJson(Map<String, Object?> json) => Persona(
    id: json['_id'] as int,
    name: json['name'] as String,
    roleId: json['roleId'] as int,
    isAlreadySelected: json['isAlreadySelected'] as int
  );

  Map<String, Object?> toJson() {
    return {
      PersonaFields.id: id,
      PersonaFields.name: name,
      PersonaFields.roleId: roleId,
      PersonaFields.isAlreadySelected: isAlreadySelected
    };
  }
}