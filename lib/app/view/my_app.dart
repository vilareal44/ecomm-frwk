import 'package:ecomm/app/theme/app_theme.dart';
import 'package:ecomm/features/auth/domain/entities/entities.dart';
import 'package:ecomm/features/auth/domain/repositories/user_repository.dart';
import 'package:ecomm/features/shopping_cart/domain/usecases/usecases.dart';
import 'package:ecomm/features/shopping_cart/presentation/bloc/shopping_cart_cubit.dart';
import 'package:ecomm/route_service.dart';
import 'package:ecomm/routes.dart';
import 'package:ecomm/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../bloc/app_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final routeService = sl.get<RouteService>();
    final appBloc = AppBloc(
      user: user,
      userRepository: sl.get<UserRepository>(),
    );

    final routerConfig = routeService.getRouter(appBloc);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (_) => appBloc,
          ),
          BlocProvider(
            lazy: false,
            create: (_) => ShoppingCartCubit(
              getShoppingCartUseCase: sl.get<GetShoppingCartUseCase>(),
              clearShoppingCartUseCase: sl.get<ClearShoppingCartUseCase>(),
              addToCartUseCase: sl.get<AddToCartUseCase>(),
            )..load(),
          ),
        ],
        child: MaterialAppView(
          routerConfig: routerConfig,
        ));
  }
}

class MaterialAppView extends StatelessWidget {
  const MaterialAppView({super.key, required this.routerConfig});

  final GoRouter routerConfig;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (contex, state) => MaterialApp.router(
        theme: const AppTheme().themeData,
        locale: state.locale,
        debugShowCheckedModeBanner: false,
        routerConfig: routerConfig,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
