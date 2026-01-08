enum PaintMode {
  pen('PEN'),
  eraser('ERASER');

  final String value;
  const PaintMode(this.value);

  static PaintMode fromValue(String value) {
    return PaintMode.values.firstWhere((paintMode) => paintMode.value == value, orElse: () => PaintMode.pen);
  }
}