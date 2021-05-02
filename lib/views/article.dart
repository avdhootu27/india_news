import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatefulWidget {

  final String BlogUrl;
  Article({this.BlogUrl});

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('India'),
            Text('News',style: TextStyle(
              color: Colors.blue,
            ),),
          ],
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
        elevation: 0.0,
      ),
      body: Container(

        child: WebView(
          initialUrl: widget.BlogUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}

