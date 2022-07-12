import 'package:flutter/material.dart';
import 'package:onwords_invoice/pdf_page.dart';

import 'api/pdf_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PdfPage(),
    );
  }
}


