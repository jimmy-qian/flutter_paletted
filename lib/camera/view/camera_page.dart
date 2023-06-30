import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paletted/camera/widgets/capture_button.dart';
import 'package:flutter_paletted/result/result.dart';
import 'package:flutter_paletted/widgets/layout/root_wrapper.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({
    required this.camera,
    super.key,
  });

  final CameraDescription camera;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  // useEffect - Lifecycle method after the widget is first 'mounted'
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
      imageFormatGroup: ImageFormatGroup.yuv420,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  // Clean up for controllers on 'unmount'
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> onPressedCapture() async {
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      if (!mounted) return;

      // If the picture was taken, display it on a new screen.
      await Navigator.of(context).push(
        // ignore: inference_failure_on_instance_creation
        MaterialPageRoute(
          builder: (context) => ResultPage(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: image.path,
          ),
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RootWrapper(
      child: Column(
        children: [
          // Camera preview
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          // Controller
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CaptureButton(onPressedCapture: onPressedCapture)],
            ),
          )
        ],
      ),
    );
  }
}
