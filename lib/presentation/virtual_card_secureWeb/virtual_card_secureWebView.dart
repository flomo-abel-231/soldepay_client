import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soldepay/services/virtual_card_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VirtualCardSecureWebView extends StatefulWidget {
  final String? cardId;
  final String? cardToken;

  const VirtualCardSecureWebView({
    this.cardId,
    this.cardToken,
    super.key,
  });

  @override
  State<VirtualCardSecureWebView> createState() =>
      _VirtualCardSecureWebViewState();
}

class _VirtualCardSecureWebViewState extends State<VirtualCardSecureWebView> {
  final VirtualCardService virtualCardService = VirtualCardService();
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasCard = true;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    try {
      final cardId = widget.cardId ?? await virtualCardService.getCardId();
      final cardToken =
          widget.cardToken ?? await virtualCardService.getCardToken();

      if (cardId == null || cardToken == null) {
        setState(() {
          _hasCard = false;
          _isLoading = false;
        });
        return;
      }

      // Load original HTML
      String html =
          await rootBundle.loadString('assets/secure_card_cardstyle.html');

      // Load and encode image to base64
      final imageBytes = await rootBundle.load('assets/card-bg.png');
      final base64Image = base64Encode(imageBytes.buffer.asUint8List());

      // Replace image path with base64 inline image
      html = html.replaceAll(
        'assets/card-bg.png',
        'data:image/png;base64,$base64Image',
      );

      // Replace card token and id placeholders
      html = html
          .replaceAll('__CARD_ID__', cardId.toString())
          .replaceAll('__CARD_TOKEN__', cardToken.toString());

      print("Injecting card credentials and base64 image into HTML.");

      // Initialize the WebViewController with final HTML
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadHtmlString(
          html,
          baseUrl:
              'https://flutter-asset/', // helps asset resolution on Android/iOS
        );

      setState(() {
        _isLoading = false;
        _hasCard = true;
      });
    } catch (e) {
      debugPrint('Error: $e');
      setState(() {
        _isLoading = false;
        _hasCard = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Secure Card'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_hasCard
              ? const Center(
                  child: Text(
                    'No virtual card at the moment.\nPlease create one and try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                )
              : WebViewWidget(controller: _controller),
    );
  }
}
