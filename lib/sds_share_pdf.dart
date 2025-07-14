import 'sds_share_pdf_platform_interface.dart';

class SdsSharePdf {
  Future<void> sharePdf(String path) {
    return SdsSharePdfPlatform.instance.sharePdf(path);
  }
}
