import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({required this.id, required this.email});

  final String id;
  final String email;

  @override
  List<Object> get props => <Object>[id];

  static const User empty = User(id: '', email: '');

  bool get isEmpty => this == empty || (id.isEmpty && email.isEmpty);

  bool get isNotEmpty => this != empty && id.isNotEmpty && email.isNotEmpty;
}
