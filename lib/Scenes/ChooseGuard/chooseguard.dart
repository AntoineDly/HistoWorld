import 'package:flutter/material.dart';
import 'package:histoworld/Scenes/Hub/hubpage.dart';
import '../../../Models/User.dart';

import '../../../Service/Database.dart';
import '../Home/homepage.dart';

class ChooseGuardPage extends StatefulWidget {
  const ChooseGuardPage({super.key});
  @override
  State<ChooseGuardPage> createState() => _ChooseGuardPageState();
}

class _ChooseGuardPageState extends State<ChooseGuardPage> {
  MaterialPageRoute returnPage = MaterialPageRoute(builder: (context) => const MyHomePage(title : 'Home'));

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
  Widget build(BuildContext context) => FutureBuilder(
      future: getUsers(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var users = (snapshot.data as List<User>).toList();
          return WillPopScope(
              onWillPop: onWillPop,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Désigner un Chef de garde'),
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
                      child: Text('Désigne le prochain chef de garde'),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('Il te suffit de cliquer sur l’un des joueurs de ton choix.'),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: List.generate(users.length, (index) {
                        return Center(
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => HubPage(user: users[index]))
                                  );
                                },
                                child: Text(users[index].name)
                            )
                        );
                      })
                    )
                  ]
                )
              )
          );
        } else {
          return const CircularProgressIndicator();
        }
      }
  );
}