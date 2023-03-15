import 'package:flutter/material.dart';
import '../../Models/User.dart';
import '../../Service/Database.dart';

import '../Hub/hubpage.dart';

class ValidateEliminationPage extends StatefulWidget {
  const ValidateEliminationPage({super.key, required this.selectedUser});
  final User selectedUser;
  @override
  State<ValidateEliminationPage> createState() => _ValidateEliminationPageState();
}

class _ValidateEliminationPageState extends State<ValidateEliminationPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<String> removeUser(User user) async {
    await ORM.instance.deleteUser(user);
    return 'null';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eliminer un joueur'),
      ),
        body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(widget.selectedUser.name + ' a été guillotiné(e).'),
              ),
              TextButton(
                  onPressed: () async {
                    await removeUser(widget.selectedUser).then((test) =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HubPage())
                      )
                    );
                  },
                  child: Text('Suivant')
              ),
            ]
        ),
    );
  }
}