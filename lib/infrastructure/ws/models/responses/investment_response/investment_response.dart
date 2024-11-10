import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'investment_response.g.dart';

@JsonSerializable()
class InvestmentResponse extends Investment {
  const InvestmentResponse({
    required super.id,
    required super.ticker,
    required super.companyName,
    required super.userId,
    required DateTime super.createdAt,
    required DateTime super.updatedAt,
    required super.companyLogoUrl,
    required super.slug,
    required super.type,
    required super.stockExchange,
    required super.currency,
    required super.description,
    required super.quantity,
    required super.isPurchased,
    required super.purchaseDate,
  });

  factory InvestmentResponse.fromJson(Map<String, dynamic> json) =>
      _$InvestmentResponseFromJson(json);

  @override
  String toString() {
    if (kDebugMode) {
      return 'InvestmentResponse('
          'id: $id, '
          'ticker: $ticker, '
          'companyName: $companyName, '
          'userId: $userId, '
          'createdAt: $createdAt, '
          'updatedAt: $updatedAt,'
          'companyLogoUrl: $companyLogoUrl,'
          'slug: $slug,'
          'type: $type,'
          'stockExchange: $stockExchange,'
          'currency: $currency,'
          'description: $description,'
          'quantity: $quantity,'
          'isPurchased: $isPurchased,'
          'purchaseDate: $purchaseDate,'
          ')';
    } else {
      return super.toString();
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! InvestmentResponse) return false;
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
