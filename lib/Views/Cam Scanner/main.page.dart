import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unitool/Views/Cam%20Scanner/images.list.dart';
import 'package:unitool/Views/Cam%20Scanner/selected.images.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ImagesList imagesList = ImagesList();
  Future<PermissionStatus> storagePermissionStatus() async {
    PermissionStatus storagePermissionStatus = await Permission.storage.status;
    if (!storagePermissionStatus.isGranted) {
      await Permission.storage.request();
    }
    storagePermissionStatus = await Permission.storage.status;
    return storagePermissionStatus;
  }

  Future<PermissionStatus> cameraPermissionStatus() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    if (!cameraPermissionStatus.isGranted) {
      await Permission.camera.request();
    }
    cameraPermissionStatus = await Permission.camera.status;
    return cameraPermissionStatus;
  }

  void pickGalleryImage() async {
  try {
    PermissionStatus status = await storagePermissionStatus();
    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final List<XFile> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        imagesList.clearImagesList();
        imagesList.imagePaths.addAll(images);
        if (!mounted) return;
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectedImages()));
      }
    }
  } catch (e) {
    print("Error picking gallery image: $e");
  }
}


  void captureCameraImage() async {
    PermissionStatus status = await cameraPermissionStatus();
    if (status.isGranted) {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        imagesList.clearImagesList();
        imagesList.imagePaths.add(image);
      }
      if (!mounted) return;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SelectedImages()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cam Scanner"),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialButton(
              color: Colors.teal[350],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              onPressed: pickGalleryImage,
              child: const Text("Gallery Images"),
            ),
            const Gap(10),
            MaterialButton(
              onPressed: captureCameraImage,
              color: Colors.teal[350],
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: const Text("Capture Image"),
            ),
          ],
        ),
      ),
    );
  }
}
