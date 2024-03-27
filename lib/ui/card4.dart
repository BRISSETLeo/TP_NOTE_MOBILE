import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';
import 'package:td2_flutter/ui/card2.dart';

class Ecran4 extends StatelessWidget {
  const Ecran4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démarrer une partie'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: FormWidget(),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        // Utilisez un ListView pour permettre le défilement si nécessaire
        padding: const EdgeInsets.all(16),
        children: [
          ExpansionTile(
            title: const Text(
              'Morpion',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Wrap(
                children: List.generate(
                  3,
                  (index) => buildLevelItem(
                      index, context.read<SettingViewModel>().niveauMorpion),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ExpansionTile(
            title: const Text(
              'Puissance 4',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              Wrap(
                children: List.generate(
                  20,
                  (index) => buildLevelItem(
                      index, context.read<SettingViewModel>().niveauPuissance4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLevelItem(int index, int niveau) {
    return GestureDetector(
      onTap: () {
        if (index <= niveau) {
          context.read<SettingViewModel>().niveauJeuMorpion = index + 1;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Ecran2(),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index < niveau ? Colors.green : Colors.red,
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                index < context.read<SettingViewModel>().niveauMorpion
                    ? Icons.lock_open
                    : Icons.lock,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
