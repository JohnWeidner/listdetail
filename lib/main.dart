import 'package:flutter/material.dart';
import 'package:listdetail/api_client.dart';
import 'package:listdetail/character_list_app.dart';

void main() {
  runApp(
    CharacterListApp(
      futureCharacters: fetchCharacters(url: 'http://api.duckduckgo.com/?q=simpsons+characters&format=json'),
    ),
  );
}
