import 'package:flutter/material.dart';
import 'package:td2_flutter/ui/card2.dart';
import 'package:td2_flutter/ui/voirscore.dart';

class Ecran1 extends StatelessWidget {
  const Ecran1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Ecran2()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Démarrer une partie',
                  style: TextStyle(fontSize: 25)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DisplayScore()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child:
                  const Text('Voir mes scores', style: TextStyle(fontSize: 25)),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Explication des règles',
                  style: TextStyle(fontSize: 25)),
            ),
          ],
        ),
      ),
    );
  }
}
