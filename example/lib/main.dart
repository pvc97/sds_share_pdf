import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:sds_share_pdf/sds_share_pdf.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _sdsSharePdfPlugin = SdsSharePdf();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _sharePdf() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      final path = result?.files.firstOrNull?.path;
      if (path != null) {
        await _sdsSharePdfPlugin.sharePdf(path);
      } else {
        log('No file selected');
      }
    } catch (e) {
      // Handle any errors that occur during file picking
      log('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SDS Share PDF example app'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _sharePdf,
            child: const Text('Share PDF'),
          ),
        ),
      ),
    );
  }
}
