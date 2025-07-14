package vn.softdreams.share_pdf.sds_share_pdf

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import androidx.core.content.FileProvider

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** SdsSharePdfPlugin */
class SdsSharePdfPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private lateinit var context: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "sds_share_pdf")
        channel.setMethodCallHandler(this)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "sharePDF") {
            val path = call.argument<String>("path")
            val mime = call.argument<String>("mime")

            if (path != null && mime != null) {
                sharePDF(path, mime)
                result.success(null)
            } else {
                result.error("INVALID_ARGUMENTS", "Path or MIME type is null", null)
            }
        } else {
            result.notImplemented()
        }
    }

    private fun sharePDF(path: String, mime: String) {
        val file = File(path)

        val uri = FileProvider.getUriForFile(
            context,
            "${context.packageName}.file_provider",
            file
        )

        val intentShareFile = Intent(Intent.ACTION_SEND).apply {
            type = mime
            putExtra(Intent.EXTRA_STREAM, uri)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }

        val chooser = Intent.createChooser(intentShareFile, "Share File").apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        // Sửa lỗi Permission Denial: reading FileProvider uri content...
        // REF: https://stackoverflow.com/a/59439316
        // => Cần cấp quyền đọc và ghi tạm thời cho các ứng dụng nhận Intent
        val resInfoList = context.packageManager.queryIntentActivities(chooser, PackageManager.MATCH_DEFAULT_ONLY)
        for (resolveInfo in resInfoList) {
            val packageName = resolveInfo.activityInfo.packageName
            context.grantUriPermission(
                packageName,
                uri,
                Intent.FLAG_GRANT_READ_URI_PERMISSION or Intent.FLAG_GRANT_WRITE_URI_PERMISSION
            )
        }

        context.startActivity(chooser)
    }


    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}