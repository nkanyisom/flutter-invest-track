import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:investtrack/infrastructure/ws/models/responses/investment_response/investment_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:models/models.dart';

part 'investments_response.g.dart';

@JsonSerializable()
class InvestmentsResponse implements Investments {
  const InvestmentsResponse({
    required this.investments,
    required this.totalPages,
    required this.currentPage,
  });

  factory InvestmentsResponse.fromJson(Map<String, dynamic> json) {
    return _$InvestmentsResponseFromJson(json);
  }

  @override
  @JsonKey(name: 'investments')
  final List<InvestmentResponse> investments;
  @override
  @JsonKey(name: 'totalPages')
  final int totalPages;

  @override
  @JsonKey(name: 'currentPage')
  final int currentPage;

  @override
  String toString() {
    if (kDebugMode) {
      return 'InvestmentsResponse('
          'investments: $investments, '
          'totalPages: $totalPages,'
          'currentPage: $currentPage,'
          ')';
    } else {
      return super.toString();
    }
  }

  Map<String, dynamic> toJson() => _$InvestmentsResponseToJson(this);

  InvestmentsResponse copyWith({
    List<InvestmentResponse>? investments,
    int? totalPages,
    int? currentPage,
  }) {
    return InvestmentsResponse(
      investments: investments ?? this.investments,
      totalPages: totalPages ?? this.totalPages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! InvestmentsResponse) return false;
    final bool Function(Object? e1, Object? e2) mapEquals =
        const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => investments.hashCode;
}
