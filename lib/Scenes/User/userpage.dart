import 'package:flutter/material.dart';

import 'package:histoworld/Models/User.dart';

import 'package:histoworld/Scenes/User/createuserpage.dart';

import '../../Models/NumberUsers.dart';
import '../../Models/Persona.dart';
import '../../Models/Role.dart';
import '../../Service/Database.dart';

class UserPage extends StatefulWidget {
  final User user;
  const UserPage({super.key, required this.user});
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String roleName = '';
  MaterialPageRoute newPage = MaterialPageRoute(builder: (context) => const CreateUserPage(title: 'Nouveau joueur'));
  String futurePage = 'Prochain joueurs';
  Persona persona = const Persona(
      id:0,
      name:'',
      roleId: 0,
      isAlreadySelected: 0
  );
  @override
  void initState() {
    super.initState();
    getNumberPlayers().then((numberPlayers) {
      if (numberPlayers.expected == numberPlayers.current) {
        newPage = MaterialPageRoute(builder: (context) => const CreateUserPage(title: 'Nouveau joueur'));
        futurePage = 'Commencer la partie';
      }
    });
    getPersona().then((persona) {
      setState(() {
        this.persona = persona;
      });
      getRole().then((role) {
        setState(() {
          roleName = role.name;
        });
      });
    });
  }
  Future<Persona> getPersona() async {
    return (await ORM.instance.readPersona(widget.user.personaId));
  }

  Future<Role> getRole() async {
    return (await ORM.instance.readRole(persona.roleId));
  }

  Future<NumberUsers> getNumberPlayers() async {
    return (await ORM.instance.readNumberUsers(3));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
              children: [
                const Text(
                  'Id : ',
                ),
                Text(
                  widget.user.id.toString(),
                ),
              ]
          ),
          Row(
              children: [
                const Text(
                  'Username : ',
                ),
                Text(
                  widget.user.name,
                ),
              ]
          ),
          Row(
              children: [
                const Text(
                  'Role : ',
                ),
                Text(
                    roleName
                ),
              ]
          ),
          Row(
              children: [
                const Text(
                  'PersonaName : ',
                ),
                Text(
                  persona.name,
                ),
              ]
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  newPage
                );
              },
              child: Text(futurePage)
          )
        ]

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}