import 'package:flutter/material.dart';
import '../../Models/User.dart';

import '../../Service/Database.dart';
import '../Hub/hubpage.dart';
import 'questpage.dart';

class RoundPage extends StatefulWidget {
  const RoundPage({super.key});
  @override
  State<RoundPage> createState() => _RoundPageState();
}

class _RoundPageState extends State<RoundPage> {
  MaterialPageRoute returnPage = MaterialPageRoute(builder: (context) => const HubPage());
  List<User> users = [];
  List<User> selectedUsers = [];
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
                foregroundColor: Colors.blue,
              ));
            }
          }
          return WillPopScope(
              onWillPop: onWillPop,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Partir en quête'),
                  leading: GestureDetector(
                    child: const Icon( Icons.arrow_back_ios, color: Colors.black,  ),
                    onTap: () {
                      Navigator.push(context, returnPage);
                    },
                  ),
                ),
                body: Column(
                  children: <Widget>[
                    GridView.count(
                      crossAxisCount: 2,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: List.generate(users.length, (index) {
                        return Center(
                          child: TextButton(
                            style: styles[index],
                            onPressed: () {
                              if(selectedUsers.contains(users[index])) {
                                selectedUsers.remove(users[index]);
                                setState(() {
                                  styles[index] = TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.blue,
                                  );
                                });
                              } else {
                                selectedUsers.add(users[index]);
                                setState(() {
                                  styles[index] = TextButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  );
                                });
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QuestPage(selectedUsers: selectedUsers))
                            );
                          },
                          child: Text('Valider')
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