package com.example.paint_box_flutter

import com.example.paint_box_flutter.PaintEditorModulePigeon.PaintEditorHostApi

class PaintEditorController(private val paintBoxView: PaintBoxNativeView): PaintEditorHostApi {
    override fun undo(callback: (Result<Boolean>) -> Unit) {
        try {
            paintBoxView.view?.undo()
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }
}