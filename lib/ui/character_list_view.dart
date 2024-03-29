import 'package:flutter/material.dart';
import 'package:listdetail/data/models/character.dart';

class CharacterListView extends StatefulWidget {
  const CharacterListView({
    required this.characters,
    required this.onItemSelected,
    this.selectedCharacter,
    super.key,
  });

  final List<Character> characters;
  final Character? selectedCharacter;

  final void Function(Character character) onItemSelected;

  @override
  State<CharacterListView> createState() => _CharacterListViewState();
}

class _CharacterListViewState extends State<CharacterListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.characters.length,
      itemBuilder: (context, index) {
        final character = widget.characters[index];
        return ListTile(
          title: Text(character.title, style: TextStyle(fontWeight: character == widget.selectedCharacter ? FontWeight.bold : FontWeight.normal)),
          onTap: () {
            widget.onItemSelected(character);
          },
        );
      },
    );
  }
}
