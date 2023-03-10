import 'package:flutter/material.dart';
import '../../Models/NumberBuildings.dart';
import '../../Models/User.dart';

import '../../Service/Database.dart';
import '../Hub/hubpage.dart';

class QuestPage extends StatefulWidget {
  const QuestPage({super.key, required this.selectedUsers});
  final List<User> selectedUsers;
  @override
  State<QuestPage> createState() => _QuestPageState();
}

class _QuestPageState extends State<QuestPage> {
  List<NumberBuildings> numberBuildings = [];

  @override
  void initState() {
    super.initState();
    getNumberBuildings().then((numberBuildings) {
      setState(() {
        this.numberBuildings = numberBuildings;
      });
    });
  }

  Future<List<NumberBuildings>> getNumberBuildings() async {
    return (await ORM.instance.readAllNumberBuildings());
  }

  Future<List<NumberBuildings>> protect() async {
    final newNumberBuildings = numberBuildings[0].copy(current: numberBuildings[0].current + 1);
    await ORM.instance.updateNumberBuildings(newNumberBuildings);
    return getNumberBuildings();
  }

  Future<List<NumberBuildings>> sabotate() async {
    final newNumberBuildings = numberBuildings[1].copy(current: numberBuildings[1].current + 1);
    await ORM.instance.updateNumberBuildings(newNumberBuildings);
    return getNumberBuildings();
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
                onPressed: () async {
                  await protect().then((numberBuildings) =>
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HubPage())
                    )
                  );
                },
                child: Text('Protect')
              ),
              TextButton(
                  onPressed: () async {
                    await sabotate().then((numberBuildings) =>
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HubPage())
                      )
                    );
                  },
                  child: Text('Sabotate')
              ),
            ]
        ),
    );
  }
}