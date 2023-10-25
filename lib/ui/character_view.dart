import 'package:flutter/material.dart';
import 'package:listdetail/model/character.dart';

class CharacterView extends StatelessWidget {
  final Character character;

  const CharacterView({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(character.title, textScaleFactor: 1.4, style: const TextStyle(fontWeight: FontWeight.bold)),
              Image.network(
                'https://duckduckgo.com${character.image}',
                errorBuilder: (a, b, c) => SizedBox(
                  height: 100,
                  child: Image.asset('assets/images/missing.png'),
                ),
              ),
              Text(character.description),
            ],
          ),
        ),
      ),
    );
  }
}
