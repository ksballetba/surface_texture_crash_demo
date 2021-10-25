# surface_texture_crash_demo

A new Flutter project to Show SurfaceTexture Crash on Android



## Steps to Reproduce

1. Execute `flutter run` on the code sample 
[SurfaceTextureCrashDemo](https://github.com/ksballetba/surface_texture_crash_demo)
2. ... 
App has a slider, you can slide to control surface height from 0 to 50000, usually most android devices will crash when surfaceTexture height arrive 20000 and below.

https://user-images.githubusercontent.com/30322203/138656571-dcd9af8e-2ff1-46db-92e0-f116b9df2437.mp4


3. ... 
Try use slider to make app crash.

**Expected results:** 
Texture Widget could continue work and display when when surfaceTexture BufferSize width or height too big.

**Actual results:** 
App crash certainly when surfaceTexture BufferSize width or height too big.

## Logs

```
2021-10-25 15:50:52.467 6786-6818/com.alibaba.surface_texture_crash_demo E/ture_crash_dem: [SurfaceTexture-0-6786-0] bindTextureImage: error binding external image: 0x502
2021-10-25 15:50:52.468 6786-6818/com.alibaba.surface_texture_crash_demo E/flutter: [ERROR:flutter/fml/platform/android/jni_util.cc(182)] java.lang.RuntimeException: Error during updateTexImage (see logcat for details)
        at android.graphics.SurfaceTexture.nativeUpdateTexImage(Native Method)
        at android.graphics.SurfaceTexture.updateTexImage(SurfaceTexture.java:248)
        at io.flutter.embedding.engine.renderer.SurfaceTextureWrapper.updateTexImage(SurfaceTextureWrapper.java:38)
2021-10-25 15:50:52.468 6786-6818/com.alibaba.surface_texture_crash_demo A/flutter: [FATAL:flutter/shell/platform/android/platform_view_android_jni_impl.cc(1247)] Check failed: fml::jni::CheckException(env). 
    
    
    --------- beginning of crash
2021-10-25 15:50:52.469 6786-6818/com.alibaba.surface_texture_crash_demo A/libc: Fatal signal 6 (SIGABRT), code -1 (SI_QUEUE) in tid 6818 (1.raster), pid 6786 (ture_crash_demo)
```



## Flutter Doctor

[✓] Flutter (Channel stable, 2.5.3, on macOS 11.6 20G165 darwin-x64, locale zh-Hans-CN)

    • Flutter version 2.5.3 at /Users/chenyu/Environment/flutter2.0/flutter
    
    • Upstream repository https://github.com/flutter/flutter.git
    
    • Framework revision 18116933e7 (10 days ago), 2021-10-15 10:46:35 -0700
    
    • Engine revision d3ea636dc5
    
    • Dart version 2.14.4
    
    • Pub download mirror https://pub.dartlang.org