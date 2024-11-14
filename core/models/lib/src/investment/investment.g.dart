// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Investment _$InvestmentFromJson(Map<String, dynamic> json) => Investment(
      ticker: json['ticker'] as String,
      userId: json['userId'] as String,
      currency: json['currency'] as String,
      type: json['type'] as String,
      companyLogoUrl: json['companyLogoUrl'] as String,
      stockExchange: json['stockExchange'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
      slug: json['slug'] as String? ?? '',
      id: (json['id'] as num?)?.toInt() ?? 0,
      companyName: json['companyName'] as String? ?? '',
      totalValueOnPurchase: (json['totalValueOnPurchase'] as num?)?.toDouble(),
      isPurchased: json['isPurchased'] as bool? ?? false,
      purchasePrice: (json['purchasePrice'] as num?)?.toDouble(),
      totalCurrentValue: (json['totalCurrentValue'] as num?)?.toDouble(),
      gainOrLossCad: (json['gainOrLossCad'] as num?)?.toDouble(),
      gainOrLossUsd: (json['gainOrLossUsd'] as num?)?.toDouble(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$InvestmentToJson(Investment instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'id': instance.id,
      'slug': instance.slug,
      'ticker': instance.ticker,
      'type': instance.type,
      'stockExchange': instance.stockExchange,
      'currency': instance.currency,
      'description': instance.description,
      'companyName': instance.companyName,
      'quantity': instance.quantity,
      'totalValueOnPurchase': instance.totalValueOnPurchase,
      'companyLogoUrl': instance.companyLogoUrl,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'isPurchased': instance.isPurchased,
      'purchasePrice': instance.purchasePrice,
      'totalCurrentValue': instance.totalCurrentValue,
      'gainOrLossCad': instance.gainOrLossCad,
      'gainOrLossUsd': instance.gainOrLossUsd,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
