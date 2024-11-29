// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invest_track_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestTrackError _$InvestTrackErrorFromJson(Map<String, dynamic> json) =>
    InvestTrackError(
      error: json['error'] as String,
      details: json['details'] == null
          ? null
          : Details.fromJson(json['details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvestTrackErrorToJson(InvestTrackError instance) =>
    <String, dynamic>{
      'error': instance.error,
      'details': instance.details,
    };
