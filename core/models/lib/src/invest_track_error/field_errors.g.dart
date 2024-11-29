// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_errors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FieldErrors _$FieldErrorsFromJson(Map<String, dynamic> json) => FieldErrors(
      quantity: (json['quantity'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$FieldErrorsToJson(FieldErrors instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
    };
