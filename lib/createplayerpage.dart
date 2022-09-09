import 'package:flutter/material.dart';
import 'package:histoworld/personpage.dart';

class CreatePlayerPage extends StatefulWidget {
  const CreatePlayerPage({super.key, required this.title});
  final String title;
  @override
  State<CreatePlayerPage> createState() => _CreatePlayerPageState();
}

class _CreatePlayerPageState extends State<CreatePlayerPage> {
  final nameController = TextEditingController();
  @override
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
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PersonPage(username: nameController.text)),
                    );*/
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(nameController.text),
                        );
                      },
                    );
                  },
                  child: const Text('Découvrir mon rôle')
              )
            ]
        ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}