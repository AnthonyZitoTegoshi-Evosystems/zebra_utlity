import 'dart:async';
import 'package:flutter/services.dart';
import 'package:zebrautility/ZebraPrinter.dart';

class Zebrautility {
  static const MethodChannel _channel = const MethodChannel('zebrautility');

  static Future<ZebraPrinter> getPrinterInstance(
      {Function(String name, String ipAddress, bool isWifi)? onPrinterFound,
      onPrinterDiscoveryDone,
      Function(int errorCode, String errorText)? onDiscoveryError,
      Function(String status, String color)? onChangePrinterStatus,
      onPermissionDenied}) async {
    String id = await _channel.invokeMethod("getInstance");
    ZebraPrinter printer = ZebraPrinter(id, onPrinterFound,
        onPrinterDiscoveryDone, onDiscoveryError, onChangePrinterStatus,
        onPermissionDenied: onPermissionDenied);
    return printer;
  }

  static Future<String> convertBase64ImageToZPLString(
      String data, int rotation) async {
    return await _channel.invokeMethod("convertBase64ImageToZPLString", {
      "Data": data,
      "rotation": rotation,
    });
  }
}
