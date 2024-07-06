import 'package:flutter/material.dart';
import 'package:unitool/Views/WebView/webview.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final TextEditingController _searchController = TextEditingController();

  void _searchOrNavigate() {
    String query = _searchController.text.trim();
    Uri? uri = Uri.tryParse(query);
    bool isUrl = uri != null && uri.isAbsolute;

    if (isUrl) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyWebView(url: query),
        ),
      );
    } else {
      String searchURL = 'https://www.google.com/search?q=$query';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyWebView(url: searchURL),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Image.asset("images/web.png", scale: 2.5),
            const SizedBox(height: 50),
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Enter URL or Search",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: _searchOrNavigate,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "GO",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
