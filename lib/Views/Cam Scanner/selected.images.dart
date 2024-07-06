import 'dart:io';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:unitool/Views/Cam%20Scanner/images.list.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SelectedImages extends StatefulWidget {
  const SelectedImages({super.key});

  @override
  State<SelectedImages> createState() => _SelectedImagesState();
}

class _SelectedImagesState extends State<SelectedImages> {
  ImagesList imagesList = ImagesList();
  late double progressValue = 0;
  late bool isExporting = false;
  late int convertimage = 0;
  void convertImage() async {
    setState(() {
      isExporting = true;
    });
    final pathToSave = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOCUMENTS);
    final pdf = pw.Document();
    for (final imagePath in imagesList.imagePaths) {
      final imageBytes = await File(imagePath.path).readAsBytes();
      final image = img.decodeImage(imageBytes);
      if (image != null) {
        final pdfImage = pw.MemoryImage(imageBytes);
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(child: pw.Image(pdfImage));
            },
          ),
        );
      }
      setState(() {
        convertimage++;
        progressValue = convertimage / imagesList.imagePaths.length;
      });
    }
    final outputFile = File('$pathToSave/NewPdf.pdf');
    await outputFile.writeAsBytes(await pdf.save());
    await ImageGallerySaver.saveFile(outputFile.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selected Images"),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: convertImage,
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
            Visibility(
              visible: isExporting,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: LinearProgressIndicator(
                  minHeight: 20,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                  value: progressValue,
                ),
              ),
            ),
            const Gap(10),
            Visibility(
              visible: isExporting,
              child: GridView.builder(
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
