import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
  });

  final String? email;

  final String id;

  final String? name;

  bool get isAnonymous => this == anonymous;

  static const User anonymous = User(
    id: '',
  );

  @override
  List<Object?> get props => [id, email, name];
}
