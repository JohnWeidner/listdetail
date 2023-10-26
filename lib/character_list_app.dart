import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listdetail/app_config.dart';
import 'package:listdetail/bloc/character/character_bloc.dart';
import 'package:listdetail/bloc/character/character_event.dart';
import 'package:listdetail/data/models/character.dart';
import 'package:listdetail/data/net_services/http_get.dart';
import 'package:listdetail/data/repositories/character_repository.dart';
import 'package:listdetail/ui/character_page.dart';
import 'package:listdetail/ui/home_page.dart';

class CharacterListApp extends StatelessWidget {
  const CharacterListApp({
    required this.appConfig,
    super.key,
  });

  final AppConfig appConfig;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharacterBloc>(
      create: (context) => CharacterBloc(
        characterRepository: CharacterRepository(
          characterGetter: HttpGet(appConfig.characterApiUrl),
        ),
      )..add(AppStarted()),
      child: MaterialApp(
        theme: ThemeData(colorScheme: appConfig.lightColorScheme),
        darkTheme: ThemeData(colorScheme: appConfig.darkColorScheme),
        title: appConfig.appName,
        routes: {
          '/detail': (context) {
            final character = ModalRoute.of(context)!.settings.arguments! as Character;
            return CharacterPage(character: character);
          },
        },
        home: HomePage(
          title: appConfig.appName,
        ),
      ),
    );
  }
}
