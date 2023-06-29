import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_paletted/general/root_wrapper.dart';
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
    void onPressedGenerate() {
      setState(() {
        colors = List.generate(5, (_) => getRandomColor());
      });
    }

    void onPressedDiscard() {
      Navigator.of(context).pop();
    }

    return RootWrapper(
      child: Column(
        children: [
          image,
          Expanded(
            child: Row(
              children: [for (final color in colors) ColorBlock(color: color)],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: SecondaryButton(
                      onPressed: onPressedDiscard,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    flex: 4,
                    child: PrimaryButton(
                      onPressed: onPressedGenerate,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(24),
        backgroundColor: Colors.white,
        minimumSize: const Size.fromHeight(48),
      ),
      onPressed: onPressed,
      child: Text(
        'Generate',
        style: const TextStyle().copyWith(
          color: Colors.black,
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(24),
        minimumSize: const Size.fromHeight(48),
        side: const BorderSide(
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        'Discard',
        style: const TextStyle().copyWith(
          color: Colors.white,
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
      child: ColoredBox(
        color: hexToColor(color),
        child: Center(
          child: Text(color.toUpperCase()),
        ),
      ),
    );
  }
}
