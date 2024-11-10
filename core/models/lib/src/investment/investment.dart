import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'investment.g.dart';

@JsonSerializable()
class Investment {
  const Investment({
    required this.ticker,
    required this.userId,
    this.slug = '',
    this.id = 0,
    this.type = '',
    this.stockExchange = '',
    this.currency,
    this.description,
    this.companyName = '',
    this.quantity = 0,
    this.totalValueOnPurchase,
    this.companyLogoUrl,
    this.isPurchased = false,
    this.purchaseDate,
    this.purchasePrice,
    this.totalCurrentValue,
    this.gainOrLossCad,
    this.gainOrLossUsd,
    this.createdAt,
    this.updatedAt,
  });

  const Investment.create({
    required this.ticker,
    required this.companyName,
    this.type = '',
    this.stockExchange = '',
    this.currency,
    this.description,
    this.quantity = 0,
    this.companyLogoUrl,
    this.purchaseDate,
    this.userId = '',
  })  : id = 0,
        slug = '',
        isPurchased = quantity > 0,
        totalValueOnPurchase = null,
        purchasePrice = null,
        totalCurrentValue = null,
        gainOrLossCad = null,
        gainOrLossUsd = null,
        createdAt = null,
        updatedAt = null;

  factory Investment.fromJson(Map<String, dynamic> json) =>
      _$InvestmentFromJson(json);

  @JsonKey(name: 'userId')
  final String userId;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'slug')
  final String slug;
  @JsonKey(name: 'ticker')
  final String ticker;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'stockExchange')
  final String stockExchange;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'companyName')
  final String companyName;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: 'totalValueOnPurchase')
  final double? totalValueOnPurchase;
  @JsonKey(name: 'companyLogoUrl')
  final String? companyLogoUrl;
  @JsonKey(name: 'isPurchased')
  final bool isPurchased;
  @JsonKey(name: 'purchaseDate')
  final DateTime? purchaseDate;
  @JsonKey(name: 'purchasePrice')
  final double? purchasePrice;
  @JsonKey(name: 'totalCurrentValue')
  final double? totalCurrentValue;
  @JsonKey(name: 'gainOrLossCad')
  final double? gainOrLossCad;
  @JsonKey(name: 'gainOrLossUsd')
  final double? gainOrLossUsd;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  Investment copyWith({
    String? userId,
    int? id,
    String? slug,
    String? ticker,
    String? type,
    String? stockExchange,
    String? currency,
    String? description,
    String? companyName,
    int? quantity,
    double? totalValueOnPurchase,
    String? companyLogoUrl,
    bool? isPurchased,
    DateTime? purchaseDate,
    double? purchasePrice,
    double? totalCurrentValue,
    double? gainOrLossCad,
    double? gainOrLossUsd,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Investment(
        userId: userId ?? this.userId,
        id: id ?? this.id,
        slug: slug ?? this.slug,
        ticker: ticker ?? this.ticker,
        type: type ?? this.type,
        stockExchange: stockExchange ?? this.stockExchange,
        currency: currency ?? this.currency,
        description: description ?? this.description,
        companyName: companyName ?? this.companyName,
        quantity: quantity ?? this.quantity,
        totalValueOnPurchase: totalValueOnPurchase ?? this.totalValueOnPurchase,
        companyLogoUrl: companyLogoUrl ?? this.companyLogoUrl,
        isPurchased: isPurchased ?? this.isPurchased,
        purchaseDate: purchaseDate ?? this.purchaseDate,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        totalCurrentValue: totalCurrentValue ?? this.totalCurrentValue,
        gainOrLossCad: gainOrLossCad ?? this.gainOrLossCad,
        gainOrLossUsd: gainOrLossUsd ?? this.gainOrLossUsd,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() => _$InvestmentToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Investment) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      userId.hashCode ^
      id.hashCode ^
      slug.hashCode ^
      ticker.hashCode ^
      type.hashCode ^
      stockExchange.hashCode ^
      currency.hashCode ^
      description.hashCode ^
      companyName.hashCode ^
      quantity.hashCode ^
      totalValueOnPurchase.hashCode ^
      companyLogoUrl.hashCode ^
      isPurchased.hashCode ^
      purchaseDate.hashCode ^
      purchasePrice.hashCode ^
      totalCurrentValue.hashCode ^
      gainOrLossCad.hashCode ^
      gainOrLossUsd.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
