import 'package:ecomm/features/shopping_cart/presentation/bloc/shopping_cart_cubit.dart';
import 'package:ecomm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:badges/badges.dart' as badges;

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
      builder: (context, state) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: _goBranch,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: l10n.homeBottomNavLabel,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.search),
                label: l10n.searchBottomNavLabel,
              ),
              BottomNavigationBarItem(
                icon: iconBadge(state),
                label: l10n.shoppingCartBottomNavLabel,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget iconBadge(ShoppingCartState state) {
    final itemCount = state.shoppingCart?.lineItems.length ?? 0;
    if (itemCount > 0) {
      return badges.Badge(
          badgeContent: Text('$itemCount'),
          child: const Icon(Icons.shopping_cart));
    } else {
      return const Icon(Icons.shopping_cart);
    }
  }
}
