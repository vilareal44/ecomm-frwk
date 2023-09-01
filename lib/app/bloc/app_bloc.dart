import 'dart:async';
import 'dart:ui';

import 'package:ecomm/features/auth/domain/entities/entities.dart';
import 'package:ecomm/features/auth/domain/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required UserRepository userRepository,
    required User user,
  })  : _userRepository = userRepository,
        super(
          user == User.anonymous
              ? const AppState.unauthenticated()
              : AppState.authenticated(user),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppLocaleChanged>(_onAppLocaleChanged);

    _userSubscription = _userRepository.user.listen(_userChanged);
  }

  final UserRepository _userRepository;

  late StreamSubscription<User> _userSubscription;

  void _userChanged(User user) => add(AppUserChanged(user));

  void _onUserChanged(AppUserChanged event, Emitter<AppState> emit) {
    final user = event.user;

    switch (state.status) {
      case AppStatus.authenticated:
      case AppStatus.unauthenticated:
        return user == User.anonymous
            ? emit(const AppState.unauthenticated())
            : emit(AppState.authenticated(user));
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(_userRepository.logOut());
  }

  void _onAppLocaleChanged(AppLocaleChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(locale: event.locale));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
