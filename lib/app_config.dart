import 'package:flutter/material.dart';

class AppConfig {
  AppConfig({
    required this.appName,
    required this.characterApiUrl,
    required this.lightColorScheme,
    required this.darkColorScheme,
  });

  final String appName;
  final String characterApiUrl;
  final ColorScheme lightColorScheme;
  final ColorScheme darkColorScheme;
}
