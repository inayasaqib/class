import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String url;
  const MyWebView({super.key, required this.url});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController _controller;
  int _loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _controller.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) {
        setState(() {
          _loadingPercentage = 0;
        });
      },
      onProgress: (progress) {
        setState(() {
          _loadingPercentage = progress;
        });
      },
      onPageFinished: (url) {
        setState(() {
          _loadingPercentage = 100;
        });
      },
    ));
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.addJavaScriptChannel("SnackBar", onMessageReceived: (message) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message.message)));
    });
    _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
        actions: [
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await _controller.canGoBack()) {
                await _controller.goBack();
              } else {
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('No Back History Found'),
                  ),
                );
              }
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);
              if (await _controller.canGoForward()) {
                await _controller.goForward();
              } else {
                messenger.showSnackBar(
                  const SnackBar(
                    content: Text('No Forward History Found'),
                  ),
                );
              }
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          IconButton(
            onPressed: () {
              _controller.reload();
            },
            icon: const Icon(Icons.replay_sharp),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if (_loadingPercentage < 100)
            LinearProgressIndicator(
              value: _loadingPercentage / 100.0,
            ),
        ],
      ),
    );
  }
}