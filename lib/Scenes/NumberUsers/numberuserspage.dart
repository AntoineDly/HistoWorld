import 'package:flutter/material.dart';

import '../../Models/NumberUsers.dart';
import '../../Service/Database.dart';
import '../User/createuserpage.dart';

class NumberUsersPage extends StatefulWidget {
  const NumberUsersPage({super.key, required this.title});
  final String title;

  @override
  State<NumberUsersPage> createState() => _NumberUsersPageState();
}

class _NumberUsersPageState extends State<NumberUsersPage> {
  int players = 4;
  int protecteurs = 3;
  int saboteurs = 1;

  Future<NumberUsers> initNumberUsers() async {
    final NumberUsers numberProtecteurs = NumberUsers(
        roleId: 1,
        expected: protecteurs,
        current: 0
    );
    final NumberUsers numberSaboteurs = NumberUsers(
        roleId: 2,
        expected: saboteurs,
        current: 0
    );
    final NumberUsers numberPlayers = NumberUsers(
        roleId: 3,
        expected: players,
        current: 0
    );
    ORM.instance.reset();

    await ORM.instance.createNumberUsers(numberProtecteurs);
    await ORM.instance.createNumberUsers(numberSaboteurs);
    return await ORM.instance.createNumberUsers(numberPlayers);
  }

  void _incrementCounter() {
    setState(() {
      if(players < 10) {
        players++;
      }
      getProtecteursAndSaboteurs();
    });
  }

  void _decrementCounter() {
    setState(() {
      if(players > 4) {
        players--;
      }
      getProtecteursAndSaboteurs();
    });
  }

  void getProtecteursAndSaboteurs() {
    setState(() {
      switch(players) {
        case 4: {
          protecteurs = 3;
          saboteurs = 1;
          break;
        }
        case 5: {
          protecteurs = 3;
          saboteurs = 2;
          break;
        }
        case 6: {
          protecteurs = 4;
          saboteurs = 2;
          break;
        }
        case 7: {
          protecteurs = 4;
          saboteurs = 3;
          break;
        }
        case 8: {
          protecteurs = 5;
          saboteurs = 3;
          break;
        }
        case 9: {
          protecteurs = 5;
          saboteurs = 4;
          break;
        }
        case 10: {
          protecteurs = 6;
          saboteurs = 4;
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre de joueurs'),
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
                '$players',
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
                '$protecteurs',
              ),
            ]
          ),
          Row(
            children: [
              const Text(
                'Nombre de saboteurs ',
              ),
              Text(
                '$saboteurs',
              ),
            ]
          ),
          TextButton(
              onPressed: () async {
                await initNumberUsers().then((numberOfUsers) =>
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateUserPage(
                          title: 'Nouveau Joueur'
                      )),
                    )
                );
              },
              child: const Text('Commencer')
          )
        ]
      )
    );
  }
}