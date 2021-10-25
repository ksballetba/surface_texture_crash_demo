# surface_texture_crash_demo

A new Flutter project to Show SurfaceTexture Crash on Android



## Background
I want to use Texture Widget and SurfaceTexture to display content，but I find my app would crash when content very high ,such as a long scrollable image. so I make this example app and I find most android devices will crash when surfaceTexture .setDefaultBufferSize height or width increases.



## Steps to Reproduce

1. Execute `flutter run` on the code sample 
[Complete Apk Here](https://github.com/ksballetba/surface_texture_crash_demo/blob/master/build/app/outputs/flutter-apk/app-release.apk)
2. ... 
App has a slider, you can slide to control surface height from 0 to 50000, usually most android devices will crash when surfaceTexture height arrive 20000 and below.

https://user-images.githubusercontent.com/30322203/138656571-dcd9af8e-2ff1-46db-92e0-f116b9df2437.mp4


3. ... 
Try use slider to make app crash.

**Expected results:** 
Texture Widget could continue work and display when when surfaceTexture BufferSize width or height too big.

**Actual results:** 
App crash certainly when surfaceTexture BufferSize width or height too big.

## Code

#### dart

```dart
  static Future<void> setSurfaceBufferSize({int surfaceHeight = 0}) async {
    await _channel
        .invokeMethod('setSurfaceBufferSize', {'surfaceHeight': surfaceHeight});
  }
}
```



#### Kotlin

```kotlin
private fun setSurfaceBufferSize(surfaceHeight: Int) {
  mSurfaceTexture.setDefaultBufferSize(1080,surfaceHeight)
  val canvas = mSurface.lockCanvas(null)
  canvas.drawRGB(255, 230, 15)
  mSurface.unlockCanvasAndPost(canvas)
}
```




## Logs

```
W/FlutterActivityAndFragmentDelegate(11092): A splash screen was provided to Flutter, but this is deprecated. See flutter.dev/go/android-splash-migration for migration steps.
Debug service listening on ws://127.0.0.1:53316/09ltl28ZGsQ=/ws
Syncing files to device Mi 10 Pro...
I/ture_crash_dem(11092): ProcessProfilingInfo new_methods=533 is saved saved_to_disk=1 resolve_classes_delay=8000
V/MiuiFrameworkFactory(11092): get AllImpl object = android.common.MiuiFrameworkFactoryImpl@21ea270
E/ture_crash_dem(11092): [SurfaceTexture-0-11092-0] bindTextureImage: error binding external image: 0x502
E/flutter (11092): [ERROR:flutter/fml/platform/android/jni_util.cc(182)] java.lang.RuntimeException: Error during updateTexImage (see logcat for details)
E/flutter (11092): 	at android.graphics.SurfaceTexture.nativeUpdateTexImage(Native Method)
E/flutter (11092): 	at android.graphics.SurfaceTexture.updateTexImage(SurfaceTexture.java:248)
E/flutter (11092): 	at io.flutter.embedding.engine.renderer.SurfaceTextureWrapper.updateTexImage(SurfaceTextureWrapper.java:38)
E/flutter (11092): 
F/flutter (11092): [FATAL:flutter/shell/platform/android/platform_view_android_jni_impl.cc(1247)] Check failed: fml::jni::CheckException(env). 
F/libc    (11092): Fatal signal 6 (SIGABRT), code -1 (SI_QUEUE) in tid 11161 (1.raster), pid 11092 (ture_crash_demo)
*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Build fingerprint: 'Xiaomi/cmi/cmi:11/RKQ1.200826.002/V12.5.8.0.RJACNXM:user/release-keys'
Revision: '0'
ABI: 'arm64'
Timestamp: 2021-10-25 16:33:54+0800
pid: 11092, tid: 11161, name: 1.raster  >>> com.alibaba.surface_texture_crash_demo <<<
uid: 10429
signal 6 (SIGABRT), code -1 (SI_QUEUE), fault addr --------
Abort message: '[FATAL:flutter/shell/platform/android/platform_view_android_jni_impl.cc(1247)] Check failed: fml::jni::CheckException(env). 
'
    x0  0000000000000000  x1  0000000000002b99  x2  0000000000000006  x3  0000007ac9d33ea0
    x4  0000007bc3112000  x5  0000007bc3112000  x6  0000007bc3112000  x7  0000000007bcef56
    x8  00000000000000f0  x9  2e2d2f5cc579cba0  x10 0000000000000000  x11 ffffffc0fffffbdf
    x12 0000000000000001  x13 000000000000007e  x14 0024cf0b5da1a019  x15 00002fc3946a5c69
    x16 0000007bc12bf948  x17 0000007bc129e390  x18 0000007ac68bc000  x19 0000000000002b54
    x20 0000000000002b99  x21 00000000ffffffff  x22 b400007aadc535c8  x23 b400007b2b6c6280
    x24 0000000000000000  x25 0000007ac9d36000  x26 0000000000000000  x27 0000000000000001
    x28 0000000000000051  x29 0000007ac9d33f20
    lr  0000007bc1251aa0  sp  0000007ac9d33e80  pc  0000007bc1251acc  pst 0000000000001000
backtrace:
      #00 pc 0000000000089acc  /apex/com.android.runtime/lib64/bionic/libc.so (abort+164) (BuildId: a790cdbd8e44ea8a90802da343cb82ce)
      #01 pc 000000000145b29c  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #02 pc 0000000001486b20  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #03 pc 0000000001463d60  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #04 pc 000000000145a1d8  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #05 pc 000000000145a02c  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #06 pc 0000000001480bdc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #07 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #08 pc 0000000001480ebc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #09 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #10 pc 000000000147de24  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #11 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #12 pc 0000000001480ebc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #13 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #14 pc 0000000001480ebc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #15 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #16 pc 0000000001480ebc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #17 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #18 pc 000000000147fff4  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #19 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #20 pc 0000000001480ebc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #21 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #22 pc 0000000001480ebc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #23 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #24 pc 0000000001480ebc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #25 pc 000000000147e450  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #26 pc 000000000147f2f4  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #27 pc 00000000014744bc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #28 pc 00000000014c022c  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #29 pc 00000000014c0d8c  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #30 pc 00000000014c176c  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #31 pc 00000000014c0714  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #32 pc 00000000014c0460  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #33 pc 00000000014cb694  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #34 pc 0000000001487750  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #35 pc 000000000148cf78  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #36 pc 0000000000019da8  /system/lib64/libutils.so (android::Looper::pollInner(int)+916) (BuildId: 4e69b93bf70ed592f0029dbd1097529e)
      #37 pc 00000000000199ac  /system/lib64/libutils.so (android::Looper::pollOnce(int, int*, int*, void**)+112) (BuildId: 4e69b93bf70ed592f0029dbd1097529e)
      #38 pc 0000000000012c74  /system/lib64/libandroid.so (ALooper_pollOnce+100) (BuildId: 750a93bc579fa4cf53916a18805479e5)
      #39 pc 000000000148cf00  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #40 pc 0000000001487698  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #41 pc 000000000148a8fc  /data/app/~~Bo_sKxC5S23Qbs0eIZaIVA==/com.alibaba.surface_texture_crash_demo-U9Xz0MVkWOQ-5HDupuuazg==/lib/arm64/libflutter.so (BuildId: 0e38af2b797f8f0407f485c629490ad99b418f86)
      #42 pc 00000000000eb868  /apex/com.android.runtime/lib64/bionic/libc.so (__pthread_start(void*)+64) (BuildId: a790cdbd8e44ea8a90802da343cb82ce)
      #43 pc 000000000008ba88  /apex/com.android.runtime/lib64/bionic/libc.so (__start_thread+64) (BuildId: a790cdbd8e44ea8a90802da343cb82ce)
Lost connection to device.

```



## Flutter Doctor

[✓] Flutter (Channel stable, 2.5.3, on macOS 11.6 20G165 darwin-x64, locale zh-Hans-CN)

    • Flutter version 2.5.3 at /Users/chenyu/Environment/flutter2.0/flutter
    
    • Upstream repository https://github.com/flutter/flutter.git
    
    • Framework revision 18116933e7 (10 days ago), 2021-10-15 10:46:35 -0700
    
    • Engine revision d3ea636dc5
    
    • Dart version 2.14.4
    
    • Pub download mirror https://pub.dartlang.org