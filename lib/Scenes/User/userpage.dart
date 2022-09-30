import 'package:flutter/material.dart';

import 'package:histoworld/Models/User.dart';

import 'package:histoworld/Scenes/User/createuserpage.dart';

import '../../Models/Persona.dart';
import '../../Service/Database.dart';

class UserPage extends StatefulWidget {
  final User user;
  const UserPage({super.key, required this.user});
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String roleName = '';
  Persona persona = const Persona(
      id:0,
      name:'',
      roleId: 0,
      isAlreadySelected: 0
  );
  @override
  void initState() {
    super.initState();
    getPersona().then((persona) {
      setState(() {
        this.persona = persona;
      });
    });
    getRoleName().then((roleName) {
      setState(() {
        this.roleName = roleName;
      });
    });
  }
  Future<Persona> getPersona() async {
    return (await ORM.instance.readPersona(widget.user.personaId));
  }

  Future<String> getRoleName() async {
    return (await ORM.instance.readRole(persona.roleId)).name;
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
                  MaterialPageRoute(builder: (context) => const CreateUserPage(title: 'Nouveau joueur')),
                );
              },
              child: const Text('Prochain joueurs')
          )
        ]

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}