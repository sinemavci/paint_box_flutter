package com.example.paint_box_flutter.dto

import android.graphics.Color
import android.os.Build
import androidx.annotation.RequiresApi

data class ColorDTO(
    val red: Double,
    val green: Double,
    val blue: Double,
    val alpha: Double = 255.0,
) {
    companion object {
        @RequiresApi(Build.VERSION_CODES.O)
        fun fromDataModel(color: Color): ColorDTO {
            return ColorDTO(
                red = color.red().toDouble(),
                green = color.green().toDouble(),
                blue = color.blue().toDouble(),
                alpha = color.alpha().toDouble()
            )
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun toDataModel(): Color {
        return Color.valueOf(red.toFloat(), green.toFloat(), blue.toFloat(), alpha.toFloat())
    }
}