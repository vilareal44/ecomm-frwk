import 'dart:io';

import 'package:ecomm/app/constants/constants.dart';
import 'package:ecomm/app/widgets/widgets.dart';
import 'package:ecomm/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';

import '../bloc/login_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ??
                    l10n.signInAuthenticationErrorMessage),
              ),
            );
        }
      },
      child: const Align(
        alignment: Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(),
              Gap(AppSpacing.sm),
              _EmailInput(),
              Gap(AppSpacing.sm),
              _PasswordInput(),
              Gap(AppSpacing.sm),
              _LoginButton(),
              Gap(AppSpacing.md),
              // _SignUpButton(),
              // // // _SignUpBoxButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'ECOMM',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class _EmailInput extends StatefulWidget {
  const _EmailInput();

  @override
  State<_EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = context.watch<LoginBloc>().state;

    return AppEmailTextField(
      controller: _controller,
      readOnly: state.status.isInProgress,
      hintText: 'email',
      onChanged: (email) =>
          context.read<LoginBloc>().add(LoginEmailChanged(email)),
      errorText: state.email.displayError != null
          ? l10n.signInInvalidEmailErrorMessage
          : null,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AppPasswordTextField(
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          hintText: l10n.signInPasswordHint,
          errorText: state.password.displayError != null
              ? l10n.signInInvalidPasswordErrorMessage
              : null,
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : AppButton.black(
                onPressed: state.isValid
                    ? () => context
                        .read<LoginBloc>()
                        .add(LoginWithEmailAndPasswordSubmitted())
                    : null,
                textStyle: Theme.of(context).textTheme.titleMedium,
                child: Text(l10n.signInButton),
              );
      },
    );
  }
}
