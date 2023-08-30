import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app/constants/constants.dart';
import 'app/widgets/widgets.dart';
import 'features/auth/presentation/presentation.dart';
import 'features/home/presentation/presentation.dart';
import 'features/product/presentation/presentation.dart';
import 'features/search/presentation/presentation.dart';
import 'features/shopping_cart/presentation/presentation.dart';
import 'features/checkout/presentation/presentation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellHome');
final _shellNavigatorProductKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellProduct');
final _shellNavigatorShoppingCartKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellShoppingCart');

final GoRouter myRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              name: AppRoutes.home,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return HomePage.page();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorProductKey,
          routes: [
            GoRoute(
              path: '/products',
              name: AppRoutes.search,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return SearchPage.page();
              },
              routes: [
                GoRoute(
                  path: ':productId',
                  name: AppRoutes.productDetails,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return ProductDetailPage.page(
                        productId: state.pathParameters['productId']!);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorShoppingCartKey,
          routes: [
            GoRoute(
              path: '/shopping-cart',
              name: AppRoutes.shoppingCart,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return ShoppingCartPage.page();
              },
              routes: [
                GoRoute(
                  path: 'checkout',
                  name: AppRoutes.checkout,
                  pageBuilder: (BuildContext context, GoRouterState state) {
                    return CheckoutPage.page();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/sign-in',
      name: AppRoutes.signIn,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return SignInPage.page();
      },
    ),
    GoRoute(
      path: '/sign-up',
      name: AppRoutes.signUp,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return SignUpPage.page();
      },
    ),
    GoRoute(
      path: '/forgot-password',
      name: AppRoutes.forgotPassword,
      pageBuilder: (BuildContext context, GoRouterState state) {
        return ForgotPasswordPage.page();
      },
    ),
  ],
);
