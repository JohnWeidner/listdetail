import 'package:flutter/material.dart';
import 'package:listdetail/data/models/character.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({
    required this.character,
    this.hideTitle = false,
    super.key,
  });

  final Character character;
  final bool hideTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              if (!hideTitle) Text(character.title, textScaleFactor: 1.4, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Image.network(
                'https://duckduckgo.com${character.image}',
                errorBuilder: (a, b, c) => SizedBox(
                  height: 100,
                  child: Image.asset('assets/images/missing.png'),
                ),
              ),
              const SizedBox(height: 10),
              Text(character.description),
            ],
          ),
        ),
      ),
    );
  }
}
