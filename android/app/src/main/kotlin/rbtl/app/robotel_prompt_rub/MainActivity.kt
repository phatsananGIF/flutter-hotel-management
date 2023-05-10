package com.example.hotel

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        handlerMethodChannel(flutterEngine)
    }

    private fun handlerMethodChannel(flutterEngine: FlutterEngine){
        //get flavor name
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "native").setMethodCallHandler {
            call, result -> 
            when (call.method) {
                "getFlavor" -> {
                    result.success(BuildConfig.FLAVOR)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}