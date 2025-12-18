package com.example.paint_box_flutter

import com.example.paint_box_flutter.PaintEditorModulePigeon.PaintEditorHostApi

class PaintEditorController(val paintBoxView: PaintBoxNativeView): PaintEditorHostApi {
    override fun undo(callback: (Result<Boolean>) -> Unit) {
        try {
            paintBoxView.view?.paintEditor?.undo()
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    override fun redo(callback: (Result<Boolean>) -> Unit) {
        try {
            paintBoxView.view?.paintEditor?.redo()
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    override fun reset(callback: (Result<Boolean>) -> Unit) {
        try {
            paintBoxView.view?.paintEditor?.reset()
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }
}