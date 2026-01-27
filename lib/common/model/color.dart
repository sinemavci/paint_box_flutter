class Color {
  final double red;

  final double green;

  final double blue;

  final double? alpha;

  Color({
    required this.red,
    required this.green,
    required this.blue,
    this.alpha = 255,
  });

  /// Converts JSON to [Color].
  factory Color.fromJson(Map<String, dynamic> json) {
    return Color(
      red: json["red"],
      green: json["green"],
      blue: json["blue"],
      alpha: json["alpha"],
    );
  }
}
