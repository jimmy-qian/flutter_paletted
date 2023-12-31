import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paletted/camera/view/camera_page.dart';
import 'package:flutter_paletted/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({required this.camera, super.key});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.black,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CameraPage(camera: camera),
    );
  }
}
