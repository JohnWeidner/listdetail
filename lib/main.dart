import 'package:flutter/material.dart';
import 'package:listdetail/app_config.dart';
import 'package:listdetail/app_runner.dart';

void main() {
  startApp(
    AppConfig(
      appName: 'Simpsons Character Viewer',
      characterApiUrl: 'http://api.duckduckgo.com/?q=simpsons+characters&format=json',
      lightColorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xffffdf1c),
        primary: const Color(0xffffdf1c),
        onPrimary: Colors.black,
      ),
      darkColorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xffffdf1c),
        brightness: Brightness.dark,
        primary: Colors.black,
        onPrimary: Colors.yellow,
      ),
    ),
  );
}
