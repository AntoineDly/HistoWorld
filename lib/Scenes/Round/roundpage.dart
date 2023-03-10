import 'package:flutter/material.dart';
import '../../Models/User.dart';

import '../../Service/Database.dart';
import '../Hub/hubpage.dart';

class RoundPage extends StatefulWidget {
  const RoundPage({super.key, required this.user});
  final User user;
  @override
  State<RoundPage> createState() => _RoundPageState();
}

class _RoundPageState extends State<RoundPage> {
  MaterialPageRoute returnPage = MaterialPageRoute(builder: (context) => const HubPage(title : 'Home'));
  List<User> users = [];
  List<User> selectedUsers = [];

  @override
  void initState() {
    super.initState();
    getUsers().then((users) {
      this.users = users;
    });
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
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Round'),
            leading: GestureDetector(
              child: const Icon( Icons.arrow_back_ios, color: Colors.black),
              onTap: () {
                Navigator.push(context, returnPage);
              },
            ),
          ),
          body: Center(
            child: Text(widget.user.name)
          ), //
        )
    );
  }
}