import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/User.dart';
import '../Models/Role.dart';
import '../Models/Persona.dart';

class ORM {
  static final ORM instance = ORM._init();

  static Database? _database;

  ORM._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableUsers ( 
        ${UserFields.id} $idType, 
        ${UserFields.name} $textType,
        ${UserFields.personaId} $integerType,
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableRoles ( 
        ${RoleFields.id} $idType, 
        ${RoleFields.name} $textType
      )
    ''');

    await db.execute('''
      INSERT INTO $tableRoles VALUES ( 
        1, 'protectors'
      )
    ''');

    await db.execute('''
      INSERT INTO $tableRoles VALUES ( 
        2, 'saboteurs'
      )
    ''');

    await db.execute('''
      CREATE TABLE $tablePersonas ( 
        ${PersonaFields.id} $idType, 
        ${PersonaFields.name} $textType
        ${PersonaFields.roleId} $integerType
        ${PersonaFields.isAlreadySelected} $integerType
      )
    ''');

    await db.execute('''
      INSERT INTO $tablePersonas VALUES ( 
        1, 'Protector1', 1, 0
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas VALUES ( 
        1, 'Protector2', 1, 0
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas VALUES ( 
        1, 'Saboteur1', 2, 0
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas VALUES ( 
        1, 'Saboteur2', 2, 0
      )
    ''');

  }

  Future<User> createUser(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUsers, user.toJson());

    return user.copy(id: id);
  }

  Future<User> readUser(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;

    const orderBy = '${UserFields.name} ASC';

    final result = await db.query(
        tableUsers,
        columns: PersonaFields.values,
        orderBy: orderBy
    );

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<Role> readRole(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableRoles,
      columns: RoleFields.values,
      where: '${RoleFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Role.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Persona> readPersona(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsers,
      columns: PersonaFields.values,
      where: '${PersonaFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Persona.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Persona>> readAllPersona({int isAlreadySelected = 0}) async {
    final db = await instance.database;

    const orderBy = '${PersonaFields.name} ASC';

    final result = await db.query(
        tablePersonas,
        columns: PersonaFields.values,
        where: '${PersonaFields.isAlreadySelected} = ?',
        whereArgs: [isAlreadySelected],
        orderBy: orderBy);

    return result.map((json) => Persona.fromJson(json)).toList();
  }

  Future<int> updatePersona(Persona persona) async {
    final db = await instance.database;

    return db.update(
      tablePersonas,
      persona.toJson(),
      where: '${PersonaFields.id} = ?',
      whereArgs: [persona.id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}