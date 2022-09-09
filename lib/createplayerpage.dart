import 'package:flutter/material.dart';
import 'package:histoworld/personpage.dart';

class CreatePlayerPage extends StatefulWidget {
  const CreatePlayerPage({super.key, required this.title});
  final String title;
  @override
  State<CreatePlayerPage> createState() => _CreatePlayerPageState();
}

class _CreatePlayerPageState extends State<CreatePlayerPage> {
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Joueur 1'),
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
                  onPressed: () {
                    if(nameController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PersonPage(username: nameController.text)),
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