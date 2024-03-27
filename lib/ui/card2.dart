import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:td2_flutter/repository/settingsmodel.dart';
import 'package:td2_flutter/ui/card3.dart';
import 'package:td2_flutter/ui/card4.dart';

class Ecran2 extends StatelessWidget {
  const Ecran2({super.key});

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
  String _pseudo = '';

  @override
  Widget build(BuildContext context) {
    final niveauJeuMorpion = context.read<SettingViewModel>().niveauJeuMorpion;
    final niveauJeuPuissance4 =
        context.read<SettingViewModel>().niveauJeuPuissance4;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Pseudo",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez insérer votre pseudo';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _pseudo = value;
              });
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.lightBlue,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _submit();
              }
            },
            child: const Text('Commencer la partie'),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Ecran4()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
              child: const Text('Niveaux', style: TextStyle(fontSize: 30)),
            ),
          ),
          Text(
            "Niveau choisi pour le morpion: $niveauJeuMorpion",
            style: const TextStyle(fontSize: 20),
          ),
          Text(
            "Niveau choisi pour le puissance 4: $niveauJeuPuissance4",
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<SettingViewModel>().pseudo = _pseudo;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Ecran3()),
      );
    }
  }
}
