import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'investment_request.g.dart';

@JsonSerializable(createFactory: false)
class InvestmentRequest extends Investment {
  const InvestmentRequest({
    required super.ticker,
    required super.companyName,
    required super.userId,
    required super.currency,
    required super.type,
    required super.companyLogoUrl,
    required super.stockExchange,
    required super.description,
    required super.quantity,
    required super.purchaseDate,
    super.slug,
    super.id,
    super.createdAt,
    super.updatedAt,
  });

  @override
  String toString() {
    if (kDebugMode) {
      return 'InvestmentRequest('
          'id: $id, '
          'ticker: $ticker, '
          'companyName: $companyName, '
          'userId: $userId)';
    } else {
      return super.toString();
    }
  }

  @override
  Map<String, dynamic> toJson() => _$InvestmentRequestToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! InvestmentRequest) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      ticker.hashCode ^
      companyName.hashCode ^
      userId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
