import 'package:freezed_annotation/freezed_annotation.dart';
import 'color.dart';

part 'color_dto.freezed.dart';
part 'color_dto.g.dart';

@freezed
class ColorDTO with _$ColorDTO {
  const ColorDTO._();

  const factory ColorDTO({
    required double red,
    required double green,
    required double blue,
    double? alpha,
  }) = _ColorDTO;

  factory ColorDTO.fromJson(Map<String, dynamic> json) =>
      _$ColorDTOFromJson(json);

  factory ColorDTO.fromDataModel(Color model) {
    return ColorDTO(
      red: model.red,
      green: model.green,
      blue: model.blue,
      alpha: model.alpha,
    );
  }

  Color toDataModel() =>
      Color(red: red, green: green, blue: blue, alpha: alpha);

  @override
  // ignore: recursive_getters
  double? get alpha => alpha;

  @override
  // ignore: recursive_getters
  double get blue => blue;

  @override
  // ignore: recursive_getters
  double get green => green;

  @override
  // ignore: recursive_getters
  double get red => red;

  @override
  Map<String, dynamic> toJson() {
    return {'red': red, 'green': green, 'blue': blue, 'alpha': alpha};
  }
}
