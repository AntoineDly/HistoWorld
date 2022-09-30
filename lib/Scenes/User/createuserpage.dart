import 'package:flutter/material.dart';
import 'package:histoworld/Models/User.dart';

import '../../Models/Persona.dart';
import '../../Service/Database.dart';
import 'userpage.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key, required this.title});
  final String title;
  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController nameController = TextEditingController();
  List<Persona> personas = [];

  Future<User> addUser(username) async {
    getPersonas().then((response){
      personas = response;
    });

    Persona persona = personas[0];

    final user = User(
      name: username,
      personaId: persona.id ?? 1
    );

    persona.copy(isAlreadySelected: 1);
    await ORM.instance.updatePersona(persona);

    return await ORM.instance.createUser(user);
  }

  Future<List<Persona>> getPersonas() async {
    return await ORM.instance.readAllPersona();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Nouveau Joueur'),
        ),
        body: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username',
                ),
              ),
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
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}