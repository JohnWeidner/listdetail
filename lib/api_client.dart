import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:listdetail/model/character.dart';

Future<List<Character>> fetchCharacters({required String url}) async {
  const nameDescriptionSeparator = ' - ';
  //await Future.delayed(const Duration(seconds: 3)); // TODO delete this line
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    print(responseJson);
    final charactersJson = responseJson['RelatedTopics'];
    final characters = <Character>[];
    for (final characterJson in charactersJson) {
      String icon = characterJson['Icon']['URL'];
      String text = characterJson['Text'];
      int separatorPos = text.indexOf(nameDescriptionSeparator);
      if (text.contains(nameDescriptionSeparator)) {
        characters.add(Character(
          image: icon,
          title: text.substring(0, separatorPos),
          description: text.substring(separatorPos + nameDescriptionSeparator.length),
        ));
      } else {
        characters.add(Character(
          image: icon,
          title: text.substring(0, 10),
          description: text,
        ));
      }
    }
    return characters;
  } else {
    throw Exception('Failed to fetch characters');
  }
}
