import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:listdetail/app_config.dart';
import 'package:listdetail/character_list_app.dart';
import 'package:path_provider/path_provider.dart';

Future<void> startApp(AppConfig appConfig) async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(
    CharacterListApp(
      appConfig: appConfig,
    ),
  );
}
