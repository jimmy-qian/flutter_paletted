import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paletted/camera/view/camera_page.dart';
import 'package:flutter_paletted/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({required this.camera, super.key});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CameraPage(camera: camera),
    );
  }
}