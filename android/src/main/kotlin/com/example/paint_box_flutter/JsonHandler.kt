package com.example.paint_box_flutter

import com.google.gson.Gson
import com.google.gson.GsonBuilder

object JsonHandler {
    val converter: Gson = GsonBuilder()
        .create()
}
