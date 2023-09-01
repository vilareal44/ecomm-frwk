import 'package:ecomm/app/widgets/widgets.dart';
import 'package:ecomm/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:ecomm/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  static Page page() => const MaterialPage<void>(child: SignInPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        signInWithEmail: sl.get<SignInWithEmail>(),
      ),
      child: const Scaffold(
        body: SafeArea(
          child: ContainerLimited(
            child: SignInForm(),
          ),
        ),
      ),
    );
  }
}
