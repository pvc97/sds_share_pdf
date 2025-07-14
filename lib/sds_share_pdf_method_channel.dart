import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sds_share_pdf_platform_interface.dart';

/// An implementation of [SdsSharePdfPlatform] that uses method channels.
class MethodChannelSdsSharePdf extends SdsSharePdfPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sds_share_pdf');

  @override
  Future<void> sharePdf(String path) async {
    try {
      await methodChannel.invokeMethod('sharePDF', {
        'path': path,
        'mime': 'application/pdf',
      });
    } catch (e) {
      log("Failed to share: '$e");
    }
  }
}
