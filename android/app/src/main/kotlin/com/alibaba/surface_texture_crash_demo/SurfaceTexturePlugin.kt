package com.alibaba.surface_texture_crash_demo

import android.graphics.SurfaceTexture
import android.view.Surface
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** KotlinPluginTestPlugin */
class SurfaceTexturePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var mFlutterPluginBinding: FlutterPlugin.FlutterPluginBinding

    private lateinit var mSurfaceTexture: SurfaceTexture

    private lateinit var mSurface: Surface

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "surface_texture_test")
        channel.setMethodCallHandler(this)
        mFlutterPluginBinding = flutterPluginBinding
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "generateSurfaceTexture") {
            val surfaceHeight = call.argument<Int>("surfaceHeight")
            val textureId = generateSurfaceTexture(surfaceHeight ?: 0)
            result.success(textureId)
        } else if (call.method == "setSurfaceBufferSize") {
            val surfaceHeight = call.argument<Int>("surfaceHeight")
            setSurfaceBufferSize(surfaceHeight ?: 0)
            result.success(null)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun generateSurfaceTexture(surfaceHeight: Int): Long {
        val textureRegistry = mFlutterPluginBinding.textureRegistry
        val surfaceTextureEntry = textureRegistry.createSurfaceTexture()
        mSurfaceTexture = surfaceTextureEntry.surfaceTexture()
        mSurfaceTexture.setDefaultBufferSize(1080, surfaceHeight)
        mSurface = Surface(mSurfaceTexture)
        val canvas = mSurface.lockCanvas(null)
        canvas.drawRGB(255, 230, 15)
        mSurface.unlockCanvasAndPost(canvas)
        return surfaceTextureEntry.id()
    }

    private fun setSurfaceBufferSize(surfaceHeight: Int) {
        mSurfaceTexture.setDefaultBufferSize(1080,surfaceHeight)
        val canvas = mSurface.lockCanvas(null)
        canvas.drawRGB(255, 230, 15)
        mSurface.unlockCanvasAndPost(canvas)
    }
}
