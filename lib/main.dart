import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:surface_texture_crash_demo/surface_texture_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const int kUninitializedId = -1;

  int _textureId = kUninitializedId;

  int currentSurfaceHeight = 0;

  @override
  void initState() {
    super.initState();
    initTextureState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initTextureState() async {
    int textureId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      textureId = await SurfaceTexturePlugin.generateSurfaceTexture(
              surfaceHeight: currentSurfaceHeight) ??
          kUninitializedId;
    } on PlatformException {
      textureId = kUninitializedId;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _textureId = textureId;
    });
  }

  Future<void> setTextureHeight() async {
    await SurfaceTexturePlugin.setSurfaceBufferSize(
        surfaceHeight: currentSurfaceHeight);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: _textureId == kUninitializedId
            ? Container()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'surfaceTextureHeight:$currentSurfaceHeight',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Slider.adaptive(
                        value: currentSurfaceHeight.toDouble(),
                        max: 50000,
                        min: 0,
                        onChanged: (newValue) {
                          setState(() {
                            currentSurfaceHeight = newValue.round();
                          });
                          setTextureHeight();
                        }),
                    SizedBox(
                        width: 1080,
                        height: currentSurfaceHeight.toDouble(),
                        child: Texture(textureId: _textureId)),
                  ],
                ),
              ),
      ),
    );
  }
}
