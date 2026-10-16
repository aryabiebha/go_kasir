import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'shared/layout/adaptive_app_shell.dart';

/// Root application widget configuring theme, localization, and adaptive shell.
class GoKasirApp extends StatelessWidget {
  const GoKasirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoKasir',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AdaptiveAppShell(),
    );
  }
}
