package com.example.paint_box_flutter

import android.util.Log
import com.example.paint_box_flutter.PaintEditorModulePigeon.PaintEditorHostApi

class PaintEditorController(private val paintBoxView: PaintBoxNativeView): PaintEditorHostApi {
    override fun undo(callback: (Result<Boolean>) -> Unit) {
        Log.e("undoo", "undooooooo")
        try {
            paintBoxView.paintBoxNativeView?.undo()
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }
}