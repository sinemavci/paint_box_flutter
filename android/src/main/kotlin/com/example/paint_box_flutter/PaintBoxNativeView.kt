package com.example.paint_box_flutter

import android.content.Context
import com.example.paint_box_flutter.PaintEditorModulePigeon.PaintEditorHostApi
import com.kotlin.native_drawing_plugin.PaintBoxView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.platform.PlatformView

class PaintBoxNativeView(context: Context, private val messenger: BinaryMessenger) : PlatformView {
    private var paintEditorHostApi: PaintEditorHostApi? = null
    private var paintBoxNativeView: PaintBoxView? = PaintBoxView(context)

    init {
        paintEditorHostApi = PaintEditorController(this)
        PaintEditorHostApi.setUp(messenger, paintEditorHostApi)
    }

    override fun getView(): PaintBoxView? {
        return paintBoxNativeView as PaintBoxView
    }

    override fun dispose() {
        paintBoxNativeView = null
        PaintEditorHostApi.setUp(messenger, null)
    }

}