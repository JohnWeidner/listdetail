import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:listdetail/model/character.dart';

Future<List<Character>> fetchCharacters({required String url}) async {
  const nameDescriptionSeparator = ' - ';
  //await Future.delayed(const Duration(seconds: 3)); // TODO delete this line
  final response = await http.get(Uri.parse(url));
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
        log('error parsing $characterJson');
      }
    }
    return characters;
  } else {
    throw Exception('Failed to fetch characters');
  }
}
