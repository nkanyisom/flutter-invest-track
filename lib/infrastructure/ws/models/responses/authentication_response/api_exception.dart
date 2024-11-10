import 'package:equatable/equatable.dart';
import 'package:investtrack/infrastructure/ws/models/responses/authentication_response/sign_up_error_response/sign_up_error_response.dart';

//TODO: move this model to models, because it is accessed from
// application_services, which violated the onion architecture dependency flow
// principle.
class ApiException extends Equatable implements Exception {
  const ApiException({required this.errorCode, required this.response});

  final int errorCode;
  final SignUpErrorResponse response;

  @override
  List<Object?> get props => <Object?>[errorCode, response];

  @override
  String toString() => response.toString();
}
