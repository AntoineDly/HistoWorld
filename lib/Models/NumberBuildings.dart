final String tableNumberBuildings = 'numberBuildings';

class NumberBuildingsFields {
  static final List<String> values = [id, name, current];
  static const String id = '_id';
  static const String name = 'name';
  static const String current = 'current';
}

class NumberBuildings {
  final int? id;
  final String name;
  final int current;

  const NumberBuildings({
    this.id,
    required this.name,
    required this.current,
  });

  NumberBuildings copy({
    int? id,
    String? name,
    int? current
  }) =>
      NumberBuildings(
        id: id ?? this.id,
        name: name ?? this.name,
        current: current ?? this.current,
      );

  static NumberBuildings fromJson(Map<String, Object?> json) => NumberBuildings(
    id: json['_id'] as int?,
    name: json['name'] as String,
    current: json['current'] as int
  );

  Map<String, Object?> toJson() {
    return {
      NumberBuildingsFields.id: id,
      NumberBuildingsFields.name: name,
      NumberBuildingsFields.current: current,
    };
  }
}