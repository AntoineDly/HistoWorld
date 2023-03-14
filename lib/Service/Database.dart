import 'dart:async';

import 'package:histoworld/Models/NumberUsers.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/NumberBuildings.dart';
import '../Models/User.dart';
import '../Models/Role.dart';
import '../Models/Persona.dart';

class ORM {
  static final ORM instance = ORM._init();

  static Database? _database;
  String databasePath = 'histoworld.db';

  ORM._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(databasePath);
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
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $tableUsers ( 
        ${UserFields.id} $idType, 
        ${UserFields.name} $textType,
        ${UserFields.personaId} $integerType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableRoles ( 
        ${RoleFields.id} $idType, 
        ${RoleFields.name} $textType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableNumberUsers ( 
        ${NumberUsersFields.id} $idType, 
        ${NumberUsersFields.roleId} $integerType,
        ${NumberUsersFields.expected} $integerType,
        ${NumberUsersFields.current} $integerType
      )
    ''');

    await db.execute('''
      CREATE TABLE $tableNumberBuildings ( 
        ${NumberBuildingsFields.id} $idType, 
        ${NumberBuildingsFields.name} $textType,
        ${NumberBuildingsFields.current} $integerType
      )
    ''');

    await db.execute('''
      INSERT INTO $tableRoles ('name') VALUES ( 
        'protecteurs'
      )
    ''');

    await db.execute('''
      INSERT INTO $tableRoles ('name') VALUES ( 
        'saboteurs'
      )
    ''');

    await db.execute('''
      INSERT INTO $tableRoles ('name') VALUES ( 
        'players'
      )
    ''');

    await db.execute('''
      INSERT INTO $tableNumberBuildings ('name', 'current') VALUES ( 
        'protecteurs', 0
      )
    ''');

    await db.execute('''
      INSERT INTO $tableNumberBuildings ('name', 'current') VALUES ( 
        'saboteurs', 0
      )
    ''');

    await db.execute('''
      CREATE TABLE $tablePersonas ( 
        ${PersonaFields.id} $idType, 
        ${PersonaFields.name} $textType,
        ${PersonaFields.roleId} $integerType,
        ${PersonaFields.isAlreadySelected} $integerType,
        ${PersonaFields.description} $textType
      )
    ''');

    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Louis XVI', 1, 0, 'Votre personnage est Louis XVI. Pour gagner, toi et ton équipe devez protéger minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Marie Antoinette', 1, 0, 'Votre personnage est Marie Antoinette. Pour gagner, toi et ton équipe devez protéger minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Elisabeth de France', 1, 0, 'Votre personnage est Elisabeth de France. Pour gagner, toi et ton équipe devez protéger minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'René de Maupeou', 1, 0, 'Votre personnage est René de Maupeou. Pour gagner, toi et ton équipe devez protéger minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Armand Marc de Montmorin de Saint-Hérem', 1, 0, 'Votre personnage est Armand Marc de Montmorin de Saint-Hérem. Pour gagner, toi et ton équipe devez protéger minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Joseph François Foullon de Doué', 1, 0, 'Votre personnage est Joseph François Foullon de Doué. Pour gagner, toi et ton équipe devez protéger minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Jean-Sylvain Bailly', 1, 0, 'Votre personnage est Jean-Sylvain Bailly. Pour gagner, toi et ton équipe devez protéger minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Robespierre', 2, 0, 'Votre personnage est Robespierre. Pour gagner, toi et ton équipe devez saboter minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Marianne', 2, 0, 'Votre personnage est Marianne. Pour gagner, toi et ton équipe devez saboter minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Gilbert du Motier de La Fayette', 2, 0, 'Votre personnage est Gilbert du Motier de La Fayette. Pour gagner, toi et ton équipe devez saboter minimum 3 monuments parisien.'
      )
    ''');
    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Camilles Desmoulins', 2, 0, 'Votre personnage est Camilles Desmoulins. Pour gagner, toi et ton équipe devez saboter minimum 3 monuments parisien.'
      )
    ''');

    await db.execute('''
      INSERT INTO $tablePersonas ('name', 'roleId', 'isAlreadySelected', 'description') VALUES ( 
        'Jean-Joseph Mounier', 2, 0, 'Votre personnage est Jean-Joseph Mounier. Pour gagner, toi et ton équipe devez saboter minimum 3 monuments parisien.'
      )
    ''');

  }

  Future<User> createUser(User user) async {
    final db = await instance.database;

    final id = await db.insert(tableUsers, user.toJson());

    return user.copy(id: id);
  }

  Future<void> deleteUser(User user) async {
    final db = await instance.database;
    await db.delete(
        tableUsers,
        where: '${UserFields.id} = ?',
        whereArgs: [user.id]
    );
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
        columns: UserFields.values,
        orderBy: orderBy
    );

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<NumberUsers> createNumberUsers(NumberUsers numberUsers) async {
    final db = await instance.database;

    final id = await db.insert(tableNumberUsers, numberUsers.toJson());

    return numberUsers.copy(id: id);
  }

  Future<NumberUsers> readNumberUsers(int roleId) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNumberUsers,
      columns: NumberUsersFields.values,
      where: '${NumberUsersFields.id} = ?',
      whereArgs: [roleId],
    );

    if (maps.isNotEmpty) {
      return NumberUsers.fromJson(maps.first);
    } else {
      throw Exception('no NumberUsers');
    }
  }

  Future<List<NumberUsers>> readAllNumberUsers() async {
    final db = await instance.database;

    const orderBy = '${NumberUsersFields.roleId} ASC';

    final result = await db.query(
        tableNumberUsers,
        columns: NumberUsersFields.values,
        orderBy: orderBy
    );

    return result.map((json) => NumberUsers.fromJson(json)).toList();
  }

  Future<int> updateNumberUser(NumberUsers numberUser) async {
    final db = await instance.database;

    return db.update(
      tableNumberUsers,
      numberUser.toJson(),
      where: '${NumberUsersFields.id} = ?',
      whereArgs: [numberUser.id],
    );
  }

  Future<NumberBuildings> readNumberBuildings(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableNumberBuildings,
      columns: NumberBuildingsFields.values,
      where: '${NumberBuildingsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return NumberBuildings.fromJson(maps.first);
    } else {
      throw Exception('no NumberBuildings');
    }
  }

  Future<List<NumberBuildings>> readAllNumberBuildings() async {
    final db = await instance.database;

    const orderBy = '${NumberBuildingsFields.id} ASC';

    final result = await db.query(
        tableNumberBuildings,
        columns: NumberBuildingsFields.values,
        orderBy: orderBy
    );

    return result.map((json) => NumberBuildings.fromJson(json)).toList();
  }

  Future<int> updateNumberBuildings(NumberBuildings numberBuildings) async {
    final db = await instance.database;

    return db.update(
      tableNumberBuildings,
      numberBuildings.toJson(),
      where: '${NumberBuildingsFields.id} = ?',
      whereArgs: [numberBuildings.id],
    );
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
      tablePersonas,
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

  Future<List<Persona>> readAllPersonaSpecified({int roleId = 1, int isAlreadySelected = 0}) async {
    final db = await instance.database;

    const orderBy = '${PersonaFields.name} ASC';

    final result = await db.query(
        tablePersonas,
        columns: PersonaFields.values,
        where: '${PersonaFields.isAlreadySelected} = ? AND ${PersonaFields.roleId} = ?',
        whereArgs: [isAlreadySelected, roleId],
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

  void reset() {
    databaseFactory.deleteDatabase(databasePath);
    _database = null;
  }
}