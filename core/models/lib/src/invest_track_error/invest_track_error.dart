import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'details.dart';

part 'invest_track_error.g.dart';

@JsonSerializable()
class InvestTrackError {
  factory InvestTrackError.fromJson(Map<String, dynamic> json) {
    return _$InvestTrackErrorFromJson(json);
  }

  const InvestTrackError({required this.error, required this.details});

  final String error;
  final Details details;

  Map<String, dynamic> toJson() => _$InvestTrackErrorToJson(this);

  InvestTrackError copyWith({
    String? error,
    Details? details,
  }) {
    return InvestTrackError(
      error: error ?? this.error,
      details: details ?? this.details,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! InvestTrackError) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => error.hashCode ^ details.hashCode;

  @override
  String toString() => 'InvestTrackError(error: $error, details: $details)';
}
