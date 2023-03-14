import 'package:flutter/material.dart';
import 'package:histoworld/Scenes/Eliminate/validateElimination.dart';
import '../../Models/User.dart';

import '../../Service/Database.dart';
import '../Hub/hubpage.dart';

class EliminatePage extends StatefulWidget {
  const EliminatePage({super.key});
  @override
  State<EliminatePage> createState() => _EliminatePageState();
}

class _EliminatePageState extends State<EliminatePage> {
  MaterialPageRoute returnPage = MaterialPageRoute(builder: (context) => const HubPage());
  List<User> users = [];
  User? selectedUser;
  List<ButtonStyle> styles = [];
  bool hasNotBeenLoaded = true;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<List<User>> getUsers() async {
    return (await ORM.instance.readAllUsers());
  }

  Future<bool> onWillPop() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Retourner à l\'acceuil ?'),
        content: const Text('Est-ce que vous voulez vraiment retourner à l\'écran du choix de garde ?'),
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
          if(hasNotBeenLoaded) {
            hasNotBeenLoaded = false;
            List<User> listUsers = (snapshot.data as List<User>).toList();
            for (var user in listUsers){
              users.add(user);
              styles.add(TextButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
              ));
            }
          }
          return WillPopScope(
              onWillPop: onWillPop,
              child: Scaffold(
                  appBar: AppBar(
                    title: Text('Eliminer un joueur'),
                    leading: GestureDetector(
                      child: const Icon( Icons.arrow_back_ios, color: Colors.black,  ),
                      onTap: () {
                        Navigator.push(context, returnPage);
                      },
                    ),
                  ),
                  body: Column(
                    children: <Widget>[
                      Text('A la majorité, éliminez un joueur'),
                      Text('Il te suffit de cliquer sur le joueur qui a été éliminer de la partie.'),
                      GridView.count(
                          crossAxisCount: 2,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: List.generate(users.length, (index) {
                            return Center(
                                child: TextButton(
                                    style: styles[index],
                                    onPressed: () {
                                      selectedUser = users[index];
                                      setState(() {
                                        styles[index] = TextButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        );
                                      });
                                      for(var i = 0; i < users.length -1; i ++) {
                                        if(i != index) {
                                          setState(() {
                                            styles[i] = TextButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.red,
                                            );
                                          });
                                        }
                                      }
                                    },
                                    child: Text(users[index].name)
                                )
                            );
                          }
                          )
                      ),
                      Center(
                          child: TextButton(
                              onPressed: () {
                                if(selectedUser != null) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ValidateEliminationPage(selectedUser: selectedUser!))
                                  );
                                }
                              },
                              child: Text('Eliminer')
                          )
                      ),
                    ],
                  )
              )
          );
        } else {
          return const CircularProgressIndicator();
        }
      }
  );
}