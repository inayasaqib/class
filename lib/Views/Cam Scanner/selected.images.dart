import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:unitool/Views/Cam%20Scanner/images.list.dart';

class SelectedImages extends StatefulWidget {
  const SelectedImages({super.key});

  @override
  State<SelectedImages> createState() => _SelectedImagesState();
}

class _SelectedImagesState extends State<SelectedImages> {
  ImagesList imagesList = ImagesList();
  late double progressValue = 0;
   late bool isExporting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Images"),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: () {},
        color: Colors.teal[350],
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Text(
          "Convert",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: LinearProgressIndicator(
                minHeight: 20,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                valueColor: const AlwaysStoppedAnimation(Colors.green),
                value: progressValue,
              ),
            ),
            const Gap(10),
            GridView.builder(
              shrinkWrap: true,
                itemCount: imagesList.imagePaths.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Image(
                      image: FileImage(
                        File(imagesList.imagePaths[index].path),
                      ),
                      fit: BoxFit.contain,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
