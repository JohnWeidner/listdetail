import 'package:flutter/material.dart';
import 'package:listdetail/model/character.dart';
import 'package:listdetail/ui/character_view.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({
    required this.character,
    super.key,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.title),
      ),
      body: CharacterView(
        character: character,
        hideTitle: true,
      ),
    );
  }
}
