import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

import 'rates_response.dart';

part 'exchange_rate_response.g.dart';

@JsonSerializable()
class ExchangeRateResponse {
  const ExchangeRateResponse({
    this.provider,
    this.warningUpgradeToV6,
    this.terms,
    this.base,
    this.date,
    this.timeLastUpdated,
    this.ratesResponse,
  });

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) {
    return _$ExchangeRateResponseFromJson(json);
  }

  final String? provider;
  @JsonKey(name: 'WARNING_UPGRADE_TO_V6')
  final String? warningUpgradeToV6;
  final String? terms;
  final String? base;
  final String? date;
  @JsonKey(name: 'time_last_updated')
  final int? timeLastUpdated;
  @JsonKey(name: 'rates')
  final RatesResponse? ratesResponse;

  @override
  String toString() {
    return 'ExchangeRateResponse('
        'provider: $provider, '
        'warningUpgradeToV6: $warningUpgradeToV6, '
        'terms: $terms, '
        'base: $base, '
        'date: $date, '
        'timeLastUpdated: $timeLastUpdated, '
        'ratesResponse: $ratesResponse,'
        ')';
  }

  Map<String, dynamic> toJson() => _$ExchangeRateResponseToJson(this);

  ExchangeRateResponse copyWith({
    String? provider,
    String? warningUpgradeToV6,
    String? terms,
    String? base,
    String? date,
    int? timeLastUpdated,
    RatesResponse? rates,
  }) {
    return ExchangeRateResponse(
      provider: provider ?? this.provider,
      warningUpgradeToV6: warningUpgradeToV6 ?? this.warningUpgradeToV6,
      terms: terms ?? this.terms,
      base: base ?? this.base,
      date: date ?? this.date,
      timeLastUpdated: timeLastUpdated ?? this.timeLastUpdated,
      ratesResponse: rates ?? this.ratesResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ExchangeRateResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      provider.hashCode ^
      warningUpgradeToV6.hashCode ^
      terms.hashCode ^
      base.hashCode ^
      date.hashCode ^
      timeLastUpdated.hashCode ^
      ratesResponse.hashCode;
}
