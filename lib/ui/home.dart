import 'package:flutter/material.dart';
import 'card1.dart';
import 'settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JouerEnCours',
          // ignore: deprecated_member_use
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: Ecran1(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EcranSettings()));
        },
        child: const Icon(Icons.settings),
      ),
    );
  }
}
