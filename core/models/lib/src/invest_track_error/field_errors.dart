import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'field_errors.g.dart';

@JsonSerializable()
class FieldErrors {
  factory FieldErrors.fromJson(Map<String, dynamic> json) {
    return _$FieldErrorsFromJson(json);
  }

  const FieldErrors({this.quantity = const <String>[]});

  final List<String> quantity;

  Map<String, dynamic> toJson() => _$FieldErrorsToJson(this);

  FieldErrors copyWith({
    List<String>? quantity,
  }) {
    return FieldErrors(
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! FieldErrors) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => quantity.hashCode;

  @override
  String toString() => 'FieldErrors(quantity: $quantity)';
}
