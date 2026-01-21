package com.example.paint_box_flutter

import android.graphics.Bitmap
import android.util.Base64
import android.graphics.BitmapFactory
import android.graphics.Matrix
import android.media.ExifInterface
import com.example.paint_box_flutter.PaintEditorModulePigeon.PaintEditorHostApi
import android.os.Build
import androidx.annotation.RequiresApi
import com.example.paint_box_flutter.dto.ColorDTO
import com.kotlin.native_drawing_plugin.MimeType
import com.kotlin.native_drawing_plugin.PaintMode
import java.io.ByteArrayInputStream

class PaintEditorController(val paintBoxView: PaintBoxNativeView): PaintEditorHostApi {
    val gson = JsonHandler.converter

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
            val originalBitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.size)

            // 2) EXIF oku
            val exif = ExifInterface(ByteArrayInputStream(bytes))
            val orientation = exif.getAttributeInt(
                ExifInterface.TAG_ORIENTATION,
                ExifInterface.ORIENTATION_NORMAL
            )

            // 3) Rotation hesapla
            val matrix = Matrix()
            when (orientation) {
                ExifInterface.ORIENTATION_ROTATE_90 -> matrix.postRotate(90f)
                ExifInterface.ORIENTATION_ROTATE_180 -> matrix.postRotate(180f)
                ExifInterface.ORIENTATION_ROTATE_270 -> matrix.postRotate(270f)
                ExifInterface.ORIENTATION_FLIP_HORIZONTAL -> matrix.postScale(-1f, 1f)
                ExifInterface.ORIENTATION_FLIP_VERTICAL -> matrix.postScale(1f, -1f)
            }

            val finalBitmap = Bitmap.createBitmap(
                originalBitmap,
                0,
                0,
                originalBitmap.width,
                originalBitmap.height,
                matrix,
                true
            )

            paintBoxView.view?.paintEditor?.import(finalBitmap)
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

    @RequiresApi(Build.VERSION_CODES.O)
    override fun getStrokeColor(callback: (Result<String>) -> Unit) {
        try {
            val strokeColor = paintBoxView.view?.paintEditor?.getStrokeColor()
            var strokeColorDTO: ColorDTO?
            if (strokeColor != null) {
                strokeColorDTO = ColorDTO.fromDataModel(strokeColor)
                callback.invoke(Result.success(gson.toJson(strokeColorDTO)))
            } else {
                callback.invoke(Result.failure(Exception("color not found")))
            }
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun setStrokeColor(color: String, callback: (Result<Boolean>) -> Unit) {
        try {
            val color = gson.fromJson(color, ColorDTO::class.java).toDataModel()
            paintBoxView.view?.paintEditor?.setStrokeColor(color)
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    override fun getStrokeSize(callback: (Result<Double>) -> Unit) {
        try {
            val strokeSize = paintBoxView.view?.paintEditor?.getStrokeWidth()
            if (strokeSize != null) {
                callback.invoke(Result.success(strokeSize))
            } else {
                callback.invoke(Result.failure(Exception("Stroke size not found")))
            }
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }

    override fun setStrokeSize(size: Double, callback: (Result<Boolean>) -> Unit) {
        try {
            paintBoxView.view?.paintEditor?.setStrokeWidth(size)
            callback.invoke(Result.success(true))
        } catch (error: Error) {
            callback.invoke(Result.failure(error))
        }
    }
}