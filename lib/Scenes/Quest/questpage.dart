import 'package:flutter/material.dart';
import '../../Models/User.dart';

import '../Hub/hubpage.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key, required this.selectedUsers});
  final List<User> selectedUsers;
  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quête'),
      ),
        body: Column(
            children: [
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  for (var user in widget.selectedUsers) Text(user.name),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HubPage(title: 'HubPage'))
                    );
                  },
                  child: Text('Return to HubPage')
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HubPage(title: 'HubPage'))
                    );
                  },
                  child: Text('Return to HubPage')
              ),
            ]
        ),
    );
  }
}