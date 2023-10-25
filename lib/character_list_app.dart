import 'package:flutter/material.dart';
import 'package:listdetail/app_config.dart';
import 'package:listdetail/model/character.dart';
import 'package:listdetail/ui/character_page.dart';
import 'package:listdetail/ui/home_page.dart';

class CharacterListApp extends StatelessWidget {
  const CharacterListApp({
    required this.futureCharacters,
    required this.appConfig,
    super.key,
  });

  final Future<List<Character>> futureCharacters;
  final AppConfig appConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorScheme: appConfig.lightColorScheme),
      darkTheme: ThemeData(colorScheme: appConfig.darkColorScheme),
      title: 'Anywhere Project',
      routes: {
        '/detail': (context) {
          final character = ModalRoute.of(context)!.settings.arguments! as Character;
          return CharacterPage(character: character);
        },
      },
      home: HomePage(
        characters: futureCharacters,
        title: appConfig.appName,
      ),
    );
  }
}
