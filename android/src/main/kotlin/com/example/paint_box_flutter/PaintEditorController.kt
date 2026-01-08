package com.example.paint_box_flutter

import android.util.Base64
import android.graphics.BitmapFactory
import com.example.paint_box_flutter.PaintEditorModulePigeon.PaintEditorHostApi
import android.os.Build
import androidx.annotation.RequiresApi
import com.kotlin.native_drawing_plugin.MimeType
import com.kotlin.native_drawing_plugin.PaintMode

class PaintEditorController(val paintBoxView: PaintBoxNativeView): PaintEditorHostApi {
    @RequiresApi(Build.VERSION_CODES.VANILLA_ICE_CREAM)
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

    override fun import(bitmap: String, callback: (Result<Boolean>) -> Unit) {
        try {
            val clean = bitmap
            .replace("data:image/png;base64,", "")
            .replace("data:image/jpeg;base64,", "")
            val bytes = Base64.decode(clean, Base64.DEFAULT)
            val _bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)

            paintBoxView.view?.paintEditor?.import(_bitmap)
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    override fun export(path: String, mimeType: String, fileName: String, callback: (Result<Boolean>) -> Unit) {
        try {
        paintBoxView.view?.paintEditor?.export(path, MimeType.fromValue(mimeType), fileName)
        callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    override fun isEnable(callback: (Result<Boolean>) -> Unit) {
        try {
            val isEnable = paintBoxView.view?.paintEditor?.isEnable()
            callback.invoke(Result.success(isEnable ?: false))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    override fun setEnable(enable: Boolean, callback: (Result<Boolean>) -> Unit) {
        try {
            paintBoxView.view?.paintEditor?.setEnable(enable)
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    //todo here implements
    override fun setPaintMode(paintMode: String, callback: Function1<Result<Boolean>, Unit>) {
        try {
            paintBoxView.view?.paintEditor?.setPaintMode(PaintMode.valueOf(paintMode))
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    override fun getPaintMode(callback: Function1<Result<String>, Unit>) {
        try {
            val mode = paintBoxView.view?.paintEditor?.getPaintMode()
            callback.invoke(Result.success(mode?.name ?: PaintMode.PEN.name))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }
}