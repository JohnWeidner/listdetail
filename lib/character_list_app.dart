import 'package:flutter/material.dart';
import 'package:listdetail/model/character.dart';
import 'package:listdetail/ui/character_view.dart';
import 'package:listdetail/ui/home_page.dart';

class CharacterListApp extends StatelessWidget {
  const CharacterListApp({super.key, required this.futureCharacters});

  final Future<List<Character>> futureCharacters;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anywhere Project',
      routes: {
        '/detail': (context) {
          final character = ModalRoute.of(context)!.settings.arguments as Character;
          return CharacterView(character: character);
        },
      },
      home: HomePage(characters: futureCharacters),
    );
  }
}
