import 'package:ecomm/app/form_inputs/form_inputs.dart';
import 'package:ecomm/features/auth/domain/repositories/user_repository.dart';
import 'package:ecomm/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required SignInWithEmail signInWithEmail,
  })  : _signInWithEmail = signInWithEmail,
        super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginWithEmailAndPasswordSubmitted>(
        _onLoginWithEmailAndPasswordSubmitted);
  }

  final SignInWithEmail _signInWithEmail;

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _onLoginWithEmailAndPasswordSubmitted(
    LoginWithEmailAndPasswordSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (!state.isValid) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final signInEither = await _signInWithEmail.call(
      Params(
        email: state.email.value,
        password: state.password.value,
      ),
    );

    signInEither.fold(
      (failure) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'Falha na autenticação.',
        ));
      },
      (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      },
    );
  }
}
