import 'package:flutter/material.dart';

import '../Home/homepage.dart';

class HubPage extends StatefulWidget {
  const HubPage({super.key, required this.title});
  final String title;
  @override
  State<HubPage> createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  MaterialPageRoute returnPage = MaterialPageRoute(builder: (context) => const MyHomePage(title : 'Home'));
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
  Widget build(BuildContext context) {
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
        body: const Center(
          child: Text('Nice'),
        )
      )
    );
  }
}