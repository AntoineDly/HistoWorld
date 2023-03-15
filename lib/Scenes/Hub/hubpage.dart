import 'package:flutter/material.dart';
import 'package:histoworld/Scenes/ChooseGuard/chooseguard.dart';
import 'package:histoworld/Scenes/Eliminate/eliminatepage.dart';
import '../../Models/NumberBuildings.dart';
import '../../Models/User.dart';

import '../../Service/Database.dart';
import '../Home/homepage.dart';
import '../Round/roundpage.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key, this.user});
  final User? user;
  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  MaterialPageRoute returnPage = MaterialPageRoute(builder: (context) => const MyHomePage(title : 'Home'));
  List<NumberBuildings> numberBuildings = [];
  int currentNbProtecteurs = 0;
  int currentNbSaboteurs = 0;

  @override
  void initState() {
    super.initState();
    getNumberBuildings().then((numberBuildings) {
      setState(() {
        this.numberBuildings = numberBuildings;
        currentNbProtecteurs = numberBuildings[0].current;
        currentNbSaboteurs = numberBuildings[1].current;
      });
    });
  }

  Future<List<NumberBuildings>> getNumberBuildings() async {
    return (await ORM.instance.readAllNumberBuildings());
  }

  Future<List<User>> getUsers() async {
    return (await ORM.instance.readAllUsers());
  }

  Future<bool> onWillPop() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Retourner à l\'acceuil ?'),
        content: const Text('Est-ce que vous voulez vraiment quitté le jeu et retourner à l\'écran d\'acceuil ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.push(context, returnPage);
            },
            child: const Text('Oui'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          )
        ],
      ),
    );
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tableau de bord'),
            leading: GestureDetector(
              child: const Icon( Icons.arrow_back_ios, color: Colors.black,  ),
              onTap: () {
                Navigator.push(context, returnPage);
              },
            ),
          ),
          body: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text ('protecteurs : ' + currentNbProtecteurs.toString()),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text ('Saboteurs : ' + currentNbSaboteurs.toString()),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(widget.user != null ? widget.user!.name  + ' est chef de gardes.' : 'Veuillez désigner un chef de gardes'),
                ),
                TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RoundPage())
                      );
                    },
                    child: const Text('Partir en quête')
                ),
                TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EliminatePage())
                      );
                    },
                    child: const Text('Eliminer un joueur')
                ),
                TextButton(
                    onPressed: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChooseGuardPage())
                      );
                    },
                    child: const Text('Désigner le chef des gardes')
                )
              ]
          ),
        )
    );
  }
}