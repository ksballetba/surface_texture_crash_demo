import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SurfaceTexturePlugin {
  static const MethodChannel _channel = MethodChannel('surface_texture_test');

  static Future<int?> generateSurfaceTexture({int surfaceHeight = 0}) async {
    final int? textureId = await _channel.invokeMethod(
        'generateSurfaceTexture', {'surfaceHeight': surfaceHeight});
    return textureId;
  }

  static Future<void> setSurfaceBufferSize({int surfaceHeight = 0}) async {
    await _channel
        .invokeMethod('setSurfaceBufferSize', {'surfaceHeight': surfaceHeight});
  }
}
