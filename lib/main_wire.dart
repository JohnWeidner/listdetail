import 'package:flutter/material.dart';
import 'package:listdetail/app_config.dart';
import 'package:listdetail/app_runner.dart';

void main() {
  startApp(
    AppConfig(
      appName: 'The Wire Character Viewer',
      characterApiUrl: 'http://api.duckduckgo.com/?q=the+wire+characters&format=json',
      lightColorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff3f0c14),
      ),
      darkColorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xff3f0c14),
        brightness: Brightness.dark,
      ),
    ),
  );
}
