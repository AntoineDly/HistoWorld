import 'package:flutter/material.dart';
import 'package:histoworld/Scenes/Round/questpage.dart';
import '../../Models/User.dart';

class InstructionsPage extends StatefulWidget {
  const InstructionsPage({super.key, required this.selectedUsers});
  final List<User> selectedUsers;
  @override
  State<InstructionsPage> createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partir en Quête'),
      ),
      body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Voici la liste des gardes choisis :'),
            ),
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                for (var user in widget.selectedUsers) Text(user.name),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Le chef de garde distribue à chaque garde une carte protection et une carte sabotage.'
                  'Les gardes utilisent une des deux cartes protection ou sabotage et les mettent sur le bâtiment face cachée.'),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Le chef de garde mélange et retourne les cartes.'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QuestPage())
                  );
                },
                child: Text('Suivant')
            ),
          ]
      ),
    );
  }
}