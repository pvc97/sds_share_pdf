import 'sds_share_pdf_platform_interface.dart';

abstract class SdsSharePdf {
  const SdsSharePdf._();

  static Future<void> sharePdf(String path) {
    return SdsSharePdfPlatform.instance.sharePdf(path);
  }
}
