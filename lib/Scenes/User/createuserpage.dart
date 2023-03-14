import 'package:flutter/material.dart';

import '../../Extensions/List.dart';
import '../../Models/NumberUsers.dart';
import '../../Models/User.dart';
import '../../Models/Persona.dart';
import '../../Service/Database.dart';

import 'userpage.dart';
import '../NumberUsers/numberuserspage.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key, required this.title});
  final String title;
  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController nameController = TextEditingController();
  List<Persona> personas = [];
  List<NumberUsers> numberUsers = [];
  int currentNbProtecteurs = 0;
  int currentNbSaboteurs = 0;
  int currentNbPlayers = 0;
  int expectedNbprotecteurs = 0;
  int expectedNbSaboteurs = 0;

  @override
  void initState() {
    super.initState();
    getNumberUsers().then((numberUsers) {
      setState(() {
        this.numberUsers = numberUsers;
        currentNbProtecteurs = numberUsers[0].current;
        currentNbSaboteurs = numberUsers[1].current;
        currentNbPlayers = numberUsers[2].current;

        expectedNbprotecteurs = numberUsers[0].expected;
        expectedNbSaboteurs = numberUsers[1].expected;
        getPersonas().then((personas) {
          setState(() {
            this.personas = personas;
          });
        });
      });
    });
  }

  Future<User> addUser(username) async {
    Persona persona = personas.randomItem();
    final User user = User(
      name: username,
      personaId: persona.id
    );

    Persona updatedPersona = persona.copy(isAlreadySelected: 1);
    await ORM.instance.updatePersona(updatedPersona);

    int roleIndex = persona.roleId - 1;
    int newCurrentRole = numberUsers[roleIndex].current + 1;
    NumberUsers newNumberUserRole = numberUsers[roleIndex].copy(current: newCurrentRole);
    await ORM.instance.updateNumberUser(newNumberUserRole);

    int playerIndex = 2;
    int newCurrentPlayer = numberUsers[playerIndex].current + 1;
    NumberUsers newNumberUserPlayer = numberUsers[playerIndex].copy(current: newCurrentPlayer);
    await ORM.instance.updateNumberUser(newNumberUserPlayer);

    return await ORM.instance.createUser(user);
  }

  Future<List<Persona>> getPersonas() async {
    if (currentNbProtecteurs == expectedNbprotecteurs) {
      return await ORM.instance.readAllPersonaSpecified(roleId: 2);
    } else if (currentNbSaboteurs == expectedNbSaboteurs) {
      return await ORM.instance.readAllPersonaSpecified();
    } else {
      return await ORM.instance.readAllPersona();
    }
  }

  Future<List<NumberUsers>> getNumberUsers() async {
    return await ORM.instance.readAllNumberUsers();
  }

  MaterialPageRoute returnPage = MaterialPageRoute(builder: (context) => const NumberUsersPage(title : 'Nombre de joueurs'));
  Future<bool> onWillPop() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Retourner au choix du nombre de joueurs ?'),
        content: const Text('Est-ce que vous voulez vraiment quitté le jeu et retourner à l\'écran d\'acceuil ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, returnPage);
            },
            child: const Text('Oui'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          )
        ],
      ),
    );
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nouveau Joueur'),
          leading: GestureDetector(
            child: const Icon( Icons.arrow_back_ios, color: Colors.black,  ),
            onTap: () {
              Navigator.push(context, returnPage);
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Entre ton pseudonyme',
              ),
            ),
            Text('À quel camp vas-tu appartenir ?'),
            TextButton(
              onPressed: () async {
                if(nameController.text.isNotEmpty) {
                  await addUser(nameController.text).then((user) =>
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserPage(user: user))
                    )
                  );
                }
              },
              child: const Text('Découvrir mon rôle')
            )
          ]
        )
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}