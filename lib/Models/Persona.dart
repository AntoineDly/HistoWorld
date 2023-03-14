final String tablePersonas = 'personas';

class PersonaFields {
  static final List<String> values = [id, name, roleId, isAlreadySelected, description];
  static const String id = '_id';
  static const String name = 'name';
  static const String roleId = 'roleId';
  static const String isAlreadySelected = 'isAlreadySelected';
  static const String description = 'description';
}

class Persona {
  final int id;
  final String name;
  final int roleId;
  final int isAlreadySelected;
  final String description;

  const Persona({
    required this.id,
    required this.name,
    required this.roleId,
    required this.isAlreadySelected,
    required this.description
  });

  Persona copy({
    int? id,
    String? name,
    int? roleId,
    int? isAlreadySelected,
    String? description
  }) =>
      Persona(
        id: id ?? this.id,
        name: name ?? this.name,
        roleId: roleId ?? this.roleId,
        isAlreadySelected: isAlreadySelected ?? this.isAlreadySelected,
        description: description ?? this.description
      );

  static Persona fromJson(Map<String, Object?> json) => Persona(
    id: json['_id'] as int,
    name: json['name'] as String,
    roleId: json['roleId'] as int,
    isAlreadySelected: json['isAlreadySelected'] as int,
    description: json['description'] as String
  );

  Map<String, Object?> toJson() {
    return {
      PersonaFields.id: id,
      PersonaFields.name: name,
      PersonaFields.roleId: roleId,
      PersonaFields.isAlreadySelected: isAlreadySelected,
      PersonaFields.description: description
    };
  }
}