import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_change_response.g.dart';

@JsonSerializable()
class PriceChangeResponse {
  factory PriceChangeResponse.fromJson(Map<String, dynamic> json) {
    return _$PriceChangeResponseFromJson(json);
  }

  const PriceChangeResponse({required this.priceChange});

  final double priceChange;

  @override
  String toString() => 'PriceChangeResponse(priceChange: $priceChange)';

  Map<String, dynamic> toJson() => _$PriceChangeResponseToJson(this);

  PriceChangeResponse copyWith({
    double? priceChange,
  }) {
    return PriceChangeResponse(
      priceChange: priceChange ?? this.priceChange,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PriceChangeResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => priceChange.hashCode;
}
