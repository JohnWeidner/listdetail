import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:listdetail/api_client.dart';
import 'package:listdetail/app_config.dart';
import 'package:listdetail/character_list_app.dart';

Future<void> startApp(AppConfig appConfig) async {
  log('startApp for ${appConfig.appName}');
  runApp(
    CharacterListApp(
      futureCharacters: fetchCharacters(
        url: appConfig.characterApiUrl,
      ),
      appConfig: appConfig,
    ),
  );
}
