import 'package:flutter/material.dart';
import 'package:histoworld/createplayerpage.dart';

import 'models/person.dart';

class PersonPage extends StatefulWidget {
  final String username;
  const PersonPage({super.key, required this.username});
  @override
  State<PersonPage> createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  Person person = Person('', '', '');
  @override
  void initState() {
    super.initState();
    person = Person(
        widget.username,
        'protector',
        'Louis XVI'
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
              children: [
                const Text(
                  'Username : ',
                ),
                Text(
                  person.username,
                ),
              ]
          ),
          Row(
              children: [
                const Text(
                  'Role : ',
                ),
                Text(
                  person.role,
                ),
              ]
          ),
          Row(
              children: [
                const Text(
                  'PersonaName : ',
                ),
                Text(
                  person.personaName,
                ),
              ]
          )
        ]

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}