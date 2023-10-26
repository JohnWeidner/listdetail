import 'dart:convert';
import 'dart:developer';

import 'package:listdetail/data/models/character.dart';
import 'package:listdetail/data/net_services/http_get.dart';

class CharacterRepository {
  CharacterRepository({required this.characterGetter});

  final HttpGet characterGetter;

  Future<List<Character>> fetchCharacters() async {
    const nameDescriptionSeparator = ' - ';
    final response = await characterGetter.get();
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
      final charactersJson = responseJson['RelatedTopics'] as List<dynamic>;
      final characters = <Character>[];
      for (final characterJson in charactersJson) {
        try {
          final text = (characterJson as Map<String, dynamic>)['Text'] as String;
          final iconJson = characterJson['Icon'] as Map<String, dynamic>;
          final icon = iconJson['URL'] as String;
          final separatorPos = text.indexOf(nameDescriptionSeparator);
          if (text.contains(nameDescriptionSeparator)) {
            characters.add(
              Character(
                image: icon,
                title: text.substring(0, separatorPos),
                description: text.substring(separatorPos + nameDescriptionSeparator.length),
              ),
            );
          } else {
            log('unexpected Text value $text');
          }
        } catch (e) {
          // TODO - send an analytic event so that we know this API is causing an unexpected error
          log('error parsing $characterJson');
        }
      }
      return characters;
    } else {
      throw Exception('network request failed (${response.statusCode})');
    }
  }
}
