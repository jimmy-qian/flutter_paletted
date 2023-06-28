import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_paletted/service/service.dart';

import 'package:image/image.dart' as external_image;

class ResultPage extends StatefulWidget {
  const ResultPage({
    required this.imagePath,
    super.key,
  });

  final String imagePath;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Image image;
  late List<String> colors = List.generate(5, (_) => getRandomColor());

  @override
  void initState() {
    super.initState();

    image = Image.file(File(widget.imagePath));
  }

  String getRandomColor() {
    final formattedImage = external_image.decodeImage(
      File(widget.imagePath).readAsBytesSync(),
    );

    if (formattedImage == null) return '#FFFFFF';

    // Get image dimensiosn
    final randomX = Random().nextInt(formattedImage.width);
    final randomY = Random().nextInt(formattedImage.height);
    // Get random pixels
    final randomPixel = formattedImage.getPixel(randomX, randomY);
    // Extract RGB values of the random pixel
    final r = randomPixel.getChannel(external_image.Channel.red).toInt();
    final g = randomPixel.getChannel(external_image.Channel.green).toInt();
    final b = randomPixel.getChannel(external_image.Channel.blue).toInt();

    return rgbToHex(r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    void onPressGenerate() {
      setState(() {
        colors = List.generate(5, (_) => getRandomColor());
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(
        child: Column(
          children: [
            image,
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  for (final color in colors) ColorBlock(color: color)
                ],
              ),
            ),
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: onPressGenerate,
                child: const Text('Generate'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColorBlock extends StatelessWidget {
  const ColorBlock({required this.color, super.key});

  final String color;

  Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: hexToColor(color),
        child: Center(
          child: Text(color),
        ),
      ),
    );
  }
}
