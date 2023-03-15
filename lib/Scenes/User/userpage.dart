import 'package:flutter/material.dart';

import 'package:histoworld/Models/User.dart';

import '../../Models/NumberUsers.dart';
import '../../Models/Persona.dart';
import '../../Models/Role.dart';
import '../../Service/Database.dart';

import 'createuserpage.dart';
import '../NumberUsers/numberuserspage.dart';
import '../Hub/hubpage.dart';

class UserPage extends StatefulWidget {
  final User user;
  const UserPage({super.key, required this.user});
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String roleName = '';
  MaterialPageRoute newPage = MaterialPageRoute(builder: (context) => const CreateUserPage(title: 'Nouveau joueur'));
  String futurePage = 'Prochain joueur';
  Persona persona = const Persona(
      id:0,
      name:'',
      roleId: 0,
      isAlreadySelected: 0,
      description: ''
  );
  @override
  void initState() {
    super.initState();
    getNumberPlayers().then((numberPlayers) {
      if (numberPlayers.expected == numberPlayers.current) {
        newPage = MaterialPageRoute(builder: (context) => const HubPage());
        futurePage = 'Commencer la partie';
      }
    });
    getPersona().then((persona) {
      setState(() {
        this.persona = persona;
      });
      getRole().then((role) {
        setState(() {
          roleName = role.name;
        });
      });
    });
  }
  Future<Persona> getPersona() async {
    return (await ORM.instance.readPersona(widget.user.personaId));
  }

  Future<Role> getRole() async {
    return (await ORM.instance.readRole(persona.roleId));
  }

  Future<NumberUsers> getNumberPlayers() async {
    return (await ORM.instance.readNumberUsers(3));
  }

  MaterialPageRoute returnPage = MaterialPageRoute(builder: (context) => const NumberUsersPage(title : 'Nombre de joueurs'));
  Future<bool> onWillPop() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Retourner au choix du nombre de joueurs ?'),
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
          title: Text('${widget.user.name} est ...'),
          leading: GestureDetector(
            child: const Icon( Icons.arrow_back_ios, color: Colors.black,  ),
            onTap: () {
              Navigator.push(context, returnPage);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Utilisateur : ${widget.user.name}'),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('Role : $roleName'),
            ),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Personnage : ${persona.name}'),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child:  Text(
                  persona.description,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 20
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, newPage);
              },
              child: Text(futurePage)
            )
          ]
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}