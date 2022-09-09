import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Person {
  Person(this.username, this.role, this.personaName);

  String username;
  String role;
  String personaName;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}