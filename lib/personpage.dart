import 'package:flutter/material.dart';
import 'package:histoworld/createplayerpage.dart';

import 'models/person.dart';

class PersonPage extends StatefulWidget {
  const PersonPage({super.key, required this.username});
  final String username;

  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  Person person = new Person(
    username: 'test',
    role: 'protector',
    personaName: 'Louis XVI',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePlayerPage(title: 'Créer son personange')),
              );
            },
            child: const Text('Commencer'),
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}