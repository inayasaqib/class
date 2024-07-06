import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
              onPressed: () {},
              child: const Text("Gallery Images"),
            ),
            const Gap(10),
            MaterialButton(
              onPressed: () {},
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
