import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'field_errors.dart';

part 'details.g.dart';

@JsonSerializable()
class Details {
  const Details({required this.fieldErrors});

  factory Details.fromJson(Map<String, dynamic> json) {
    return _$DetailsFromJson(json);
  }

  final FieldErrors fieldErrors;

  @override
  String toString() {
    return 'Details(fieldErrors: $fieldErrors)';
  }

  Map<String, dynamic> toJson() => _$DetailsToJson(this);

  Details copyWith({
    FieldErrors? fieldErrors,
  }) {
    return Details(
      fieldErrors: fieldErrors ?? this.fieldErrors,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Details) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => fieldErrors.hashCode;
}
