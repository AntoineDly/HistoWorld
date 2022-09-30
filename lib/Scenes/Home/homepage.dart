import 'package:flutter/material.dart';
import 'package:histoworld/Scenes/NumberUsers/numberuserspage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NumberUsersPage(title: 'Nombre de joueurs')),
              );
            },
            child: const Text('Révolution  française'),
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}