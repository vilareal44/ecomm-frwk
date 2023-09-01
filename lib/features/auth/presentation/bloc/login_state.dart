part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  bool get isValid => Formz.validate([email, password]);

  @override
  List<Object?> get props => [email, password, status, errorMessage];

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    String? errorMessage,
    bool? valid,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
