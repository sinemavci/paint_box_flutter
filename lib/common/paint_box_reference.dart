import 'package:flutter/material.dart';
import 'package:paint_box_flutter/paint_box_view.dart';
import 'package:paint_box_flutter/paint_box_flutter_plugin.dart';
import 'package:collection/collection.dart';

class _PaintBoxReferenceModel {
  final PaintBoxViewState paintBoxView;
  final PaintEditor controller;

  _PaintBoxReferenceModel({
    required this.paintBoxView,
    required this.controller,
  });
}

class PaintBoxReference {
  static final PaintBoxReference _instance = PaintBoxReference._internal();

  factory PaintBoxReference() {
    return _instance;
  }

  static PaintBoxReference get instance => _instance;

  PaintBoxReference._internal();

  // ignore: library_private_types_in_public_api
  List<_PaintBoxReferenceModel> references = [];

  _PaintBoxReferenceModel? findPaintBoxReference(PaintEditor paintEditor) {
    return references.firstWhereOrNull(
      (element) => element.controller == paintEditor,
    );
  }

  void addPaintBoxReference(
    PaintBoxViewState paintBoxView,
    PaintEditor controller,
  ) {
    final existingReference =
        findPaintBoxReference(controller);
    if (existingReference == null) {
      references.add(
        _PaintBoxReferenceModel(
          paintBoxView: paintBoxView,
          controller: controller,
        ),
      );
    }
  }

  void removePaintBoxReference(PaintBoxViewState paintBoxView) {
    references.removeWhere(
      (element) => element.paintBoxView == paintBoxView,
    );
  }

  void clear() {
    references.clear();
  }

}