import 'package:flutter/material.dart';
import '../../Models/User.dart';

import '../../Service/Database.dart';
import '../Home/homepage.dart';
import '../Round/roundpage.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key, required this.title});
  final String title;
  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
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
                title: Text('Hub'),
                leading: GestureDetector(
                  child: const Icon( Icons.arrow_back_ios, color: Colors.black,  ),
                  onTap: () {
                    Navigator.push(context, returnPage);
                  },
                ),
              ),
              body: GridView.count(
                crossAxisCount: 2,
                children: List.generate(users.length, (index) {
                  return Center(
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RoundPage(user: users[index]))
                            );
                          },
                          child: Text(users[index].name)
                      )
                  );
                }),
              ),
            )
        );
      } else {
        return const CircularProgressIndicator();
      }
    }
  );
}