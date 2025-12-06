package com.example.paint_box_flutter

import android.view.View
import android.content.Context
import com.kotlin.native_drawing_plugin.PaintBoxView
import io.flutter.plugin.platform.PlatformView

class PaintBoxNativeView(context: Context) : PlatformView {
    private var paintBoxNativeView: PaintBoxView? = PaintBoxView(context)

    init {
          //todo setup host apis
    }

    override fun getView(): View? {
        return paintBoxNativeView
    }

    override fun dispose() {
        paintBoxNativeView = null
        //todo setup null host apis
    }

}