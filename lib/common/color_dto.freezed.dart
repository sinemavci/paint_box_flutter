// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'color_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ColorDTO {

 double get red; double get green; double get blue; double? get alpha;
/// Create a copy of ColorDTO
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColorDTOCopyWith<ColorDTO> get copyWith => _$ColorDTOCopyWithImpl<ColorDTO>(this as ColorDTO, _$identity);

  /// Serializes this ColorDTO to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColorDTO&&(identical(other.red, red) || other.red == red)&&(identical(other.green, green) || other.green == green)&&(identical(other.blue, blue) || other.blue == blue)&&(identical(other.alpha, alpha) || other.alpha == alpha));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,red,green,blue,alpha);

@override
String toString() {
  return 'ColorDTO(red: $red, green: $green, blue: $blue, alpha: $alpha)';
}


}

/// @nodoc
abstract mixin class $ColorDTOCopyWith<$Res>  {
  factory $ColorDTOCopyWith(ColorDTO value, $Res Function(ColorDTO) _then) = _$ColorDTOCopyWithImpl;
@useResult
$Res call({
 double red, double green, double blue, double? alpha
});




}
/// @nodoc
class _$ColorDTOCopyWithImpl<$Res>
    implements $ColorDTOCopyWith<$Res> {
  _$ColorDTOCopyWithImpl(this._self, this._then);

  final ColorDTO _self;
  final $Res Function(ColorDTO) _then;

/// Create a copy of ColorDTO
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? red = null,Object? green = null,Object? blue = null,Object? alpha = freezed,}) {
  return _then(_self.copyWith(
red: null == red ? _self.red : red // ignore: cast_nullable_to_non_nullable
as double,green: null == green ? _self.green : green // ignore: cast_nullable_to_non_nullable
as double,blue: null == blue ? _self.blue : blue // ignore: cast_nullable_to_non_nullable
as double,alpha: freezed == alpha ? _self.alpha : alpha // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ColorDTO].
extension ColorDTOPatterns on ColorDTO {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColorDTO value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColorDTO() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColorDTO value)  $default,){
final _that = this;
switch (_that) {
case _ColorDTO():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColorDTO value)?  $default,){
final _that = this;
switch (_that) {
case _ColorDTO() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double red,  double green,  double blue,  double? alpha)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColorDTO() when $default != null:
return $default(_that.red,_that.green,_that.blue,_that.alpha);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double red,  double green,  double blue,  double? alpha)  $default,) {final _that = this;
switch (_that) {
case _ColorDTO():
return $default(_that.red,_that.green,_that.blue,_that.alpha);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double red,  double green,  double blue,  double? alpha)?  $default,) {final _that = this;
switch (_that) {
case _ColorDTO() when $default != null:
return $default(_that.red,_that.green,_that.blue,_that.alpha);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ColorDTO extends ColorDTO {
  const _ColorDTO({required this.red, required this.green, required this.blue, this.alpha}): super._();
  factory _ColorDTO.fromJson(Map<String, dynamic> json) => _$ColorDTOFromJson(json);

@override final  double red;
@override final  double green;
@override final  double blue;
@override final  double? alpha;

/// Create a copy of ColorDTO
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColorDTOCopyWith<_ColorDTO> get copyWith => __$ColorDTOCopyWithImpl<_ColorDTO>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ColorDTOToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColorDTO&&(identical(other.red, red) || other.red == red)&&(identical(other.green, green) || other.green == green)&&(identical(other.blue, blue) || other.blue == blue)&&(identical(other.alpha, alpha) || other.alpha == alpha));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,red,green,blue,alpha);

@override
String toString() {
  return 'ColorDTO(red: $red, green: $green, blue: $blue, alpha: $alpha)';
}


}

/// @nodoc
abstract mixin class _$ColorDTOCopyWith<$Res> implements $ColorDTOCopyWith<$Res> {
  factory _$ColorDTOCopyWith(_ColorDTO value, $Res Function(_ColorDTO) _then) = __$ColorDTOCopyWithImpl;
@override @useResult
$Res call({
 double red, double green, double blue, double? alpha
});




}
/// @nodoc
class __$ColorDTOCopyWithImpl<$Res>
    implements _$ColorDTOCopyWith<$Res> {
  __$ColorDTOCopyWithImpl(this._self, this._then);

  final _ColorDTO _self;
  final $Res Function(_ColorDTO) _then;

/// Create a copy of ColorDTO
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? red = null,Object? green = null,Object? blue = null,Object? alpha = freezed,}) {
  return _then(_ColorDTO(
red: null == red ? _self.red : red // ignore: cast_nullable_to_non_nullable
as double,green: null == green ? _self.green : green // ignore: cast_nullable_to_non_nullable
as double,blue: null == blue ? _self.blue : blue // ignore: cast_nullable_to_non_nullable
as double,alpha: freezed == alpha ? _self.alpha : alpha // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
