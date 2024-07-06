import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitool/Provider/provider.dart';
import 'package:unitool/Views/QR%20Code%20Scanner/qr_code_scanner.dart';
import 'package:unitool/Views/WebView/mywebview.dart';
import 'package:unitool/Views/audio%20recorder/audio.dart';
import 'package:unitool/Views/Picture/picture.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Consumer<UiProvider>(
            builder: (context, UiProvider notifier, child) {
          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const ListTile(
                      title: Text(
                        "Settings",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text("Dark Theme"),
                      trailing: Switch(
                        value: notifier.isDark,
                        onChanged: (value) => notifier.changeTheme(),
                      ),
                    ),
                  ],
                );
              });
        }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 60,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QrCodeScanner()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.qr_code_scanner,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'QR Code Scanner',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 60,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  WebView()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Row(
                      children: [
                        Image(image: AssetImage("images/web.png",), width: 50, height: 50,),
                        SizedBox(width: 8),
                        Text(
                          'Web View',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 60,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Audio()));
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.mic_sharp,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Audio Recorder',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
            ],
          ),
           Row(
            children: [
              const SizedBox(
                width: 60,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CameraApp()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.image,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Camera',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
