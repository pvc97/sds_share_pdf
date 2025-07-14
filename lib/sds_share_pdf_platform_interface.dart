import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sds_share_pdf_method_channel.dart';

abstract class SdsSharePdfPlatform extends PlatformInterface {
  /// Constructs a SdsSharePdfPlatform.
  SdsSharePdfPlatform() : super(token: _token);

  static final Object _token = Object();

  static SdsSharePdfPlatform _instance = MethodChannelSdsSharePdf();

  /// The default instance of [SdsSharePdfPlatform] to use.
  ///
  /// Defaults to [MethodChannelSdsSharePdf].
  static SdsSharePdfPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SdsSharePdfPlatform] when
  /// they register themselves.
  static set instance(SdsSharePdfPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> sharePdf(String path) {
    throw UnimplementedError('sharePdf() has not been implemented.');
  }
}
