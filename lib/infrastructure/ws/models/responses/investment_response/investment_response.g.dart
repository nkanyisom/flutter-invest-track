// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestmentResponse _$InvestmentResponseFromJson(Map<String, dynamic> json) =>
    InvestmentResponse(
      id: (json['id'] as num).toInt(),
      ticker: json['ticker'] as String,
      companyName: json['companyName'] as String,
      userId: json['userId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      companyLogoUrl: json['companyLogoUrl'] as String,
      slug: json['slug'] as String?,
      type: json['type'] as String,
      stockExchange: json['stockExchange'] as String,
      currency: json['currency'] as String,
      description: json['description'] as String,
      quantity: (json['quantity'] as num).toInt(),
      isPurchased: json['isPurchased'] as bool?,
      purchaseDate: json['purchaseDate'] == null
          ? null
          : DateTime.parse(json['purchaseDate'] as String),
    );

Map<String, dynamic> _$InvestmentResponseToJson(InvestmentResponse instance) =>
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
      'companyLogoUrl': instance.companyLogoUrl,
      'purchaseDate': instance.purchaseDate?.toIso8601String(),
      'isPurchased': instance.isPurchased,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
