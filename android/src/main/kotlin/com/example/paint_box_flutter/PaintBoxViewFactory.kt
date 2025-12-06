package com.example.paint_box_flutter

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class PaintBoxViewFactory(private val messenger: BinaryMessenger) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(
        context: Context?,
        viewId: Int,
        args: Any?
    ): PlatformView {
        return PaintBoxNativeView(context!!)
    }
}