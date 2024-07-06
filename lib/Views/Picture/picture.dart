
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    try {
      await _controller.initialize();
      if (!mounted) return;

      // Try to set flash mode to auto, fallback to off if not supported
      try {
        await _controller.setFlashMode(FlashMode.auto);
      } on CameraException catch (e) {
        print("Flash mode auto not supported: ${e.description}");
        try {
          await _controller.setFlashMode(FlashMode.off);
        } on CameraException catch (e) {
          print("Flash mode off not supported: ${e.description}");
        }
      }

      setState(() {});
    } catch (e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print("Access was denied.");
            break;
          default:
            print(e.description);
            break;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: CameraPreview(_controller),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (!_controller.value.isInitialized ||
                          _controller.value.isTakingPicture) {
                        return;
                      }
                      try {
                        XFile file = await _controller.takePicture();
                        if (!mounted) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImagePreview(file)));
                      } on CameraException catch (e) {
                        debugPrint("Error Occurred while taking picture: $e");
                      }
                    },
                    color: Colors.white,
                    child: const Text('Take a Picture'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ImagePreview extends StatelessWidget {
  final XFile file;

  const ImagePreview(this.file, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Preview"),
      ),
      body: Center(
        child: Image.file(File(file.path)),
      ),
    );
  }
}
