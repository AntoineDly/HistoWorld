import 'package:flutter/material.dart';

import 'createplayerpage.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key, required this.title});
  final String title;

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int _counter = 4;
  int _protectors = 3;
  int _saboteurs = 1;

  void _incrementCounter() {
    setState(() {
      if(_counter < 10) {
        _counter++;
      }
      getProtectorsAndSaboteurs();
    });
  }

  void _decrementCounter() {
    setState(() {
      if(_counter > 4) {
        _counter--;
      }
      getProtectorsAndSaboteurs();
    });
  }

  void getProtectorsAndSaboteurs() {
    setState(() {
      switch(_counter) {
        case 4: {
          _protectors = 3;
          _saboteurs = 1;
          break;
        }
        case 5: {
          _protectors = 3;
          _saboteurs = 2;
          break;
        }
        case 6: {
          _protectors = 4;
          _saboteurs = 2;
          break;
        }
        case 7: {
          _protectors = 4;
          _saboteurs = 3;
          break;
        }
        case 8: {
          _protectors = 5;
          _saboteurs = 3;
          break;
        }
        case 9: {
          _protectors = 5;
          _saboteurs = 4;
          break;
        }
        case 10: {
          _protectors = 6;
          _saboteurs = 4;
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'acceuil'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: _decrementCounter,
                child: const Icon(Icons.remove),
              ),
              const Text(
                'Nombre de joueurs ',
              ),
              Text(
                '$_counter',
              ),
              TextButton(
                onPressed: _incrementCounter,
                child: const Icon(Icons.add),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Nombre de protecteurs ',
              ),
              Text(
                '$_protectors',
              ),
            ]
          ),
          Row(
            children: [
              const Text(
                'Nombre de saboteurs ',
              ),
              Text(
                '$_saboteurs',
              ),
            ]
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreatePlayerPage(title: 'Nombre de joueurs')),
                );
              },
              child: const Text('Commencer')
          )
        ]
      )
    );
  }
}