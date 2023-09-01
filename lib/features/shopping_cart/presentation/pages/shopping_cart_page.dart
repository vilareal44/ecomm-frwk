import 'package:ecomm/app/app.dart';
import 'package:ecomm/app/widgets/widgets.dart';
import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/presentation/bloc/bloc.dart';
import 'package:ecomm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  static Page page() => const MaterialPage<void>(child: ShoppingCartPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        child: ContainerLimited(
          child: ShoppingCartView(),
        ),
      ),
    );
  }
}

class ShoppingCartView extends StatelessWidget {
  const ShoppingCartView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ShoppingCartCubit, ShoppingCartState>(
      builder: (context, state) {
        if (state.shoppingCart == null ||
            state.shoppingCart!.lineItems.isEmpty) {
          return const _EmptyCart();
        }

        return _ShoppingCartResult(shoppingCart: state.shoppingCart!);
      },
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.remove_shopping_cart,
          size: 50,
          color: AppColors.disabledButton,
        ),
        const Gap(AppSpacing.lg),
        Text(
          l10n.shoppingCartPageEmptyCartMessage,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}

class _ShoppingCartResult extends StatelessWidget {
  const _ShoppingCartResult({super.key, required this.shoppingCart});

  final ShoppingCart shoppingCart;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CartHeader(),
        const Gap(AppSpacing.xxlg),
        _CartListCard(items: shoppingCart.lineItems),
        const Divider(),
        const Gap(AppSpacing.lg),
        _CartSummary(shoppingCart: shoppingCart),
        const Gap(AppSpacing.xxlg),
        const _CartActions(),
      ],
    );
  }
}

class _CartHeader extends StatelessWidget {
  const _CartHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Text(
      l10n.shoppingCartPageTitle,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

class _CartSummary extends StatelessWidget {
  const _CartSummary({super.key, required this.shoppingCart});

  final ShoppingCart shoppingCart;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final curFormatter = NumberFormat.currency(symbol: 'R\$');

    return Row(
        // leading: CachedNetworkImage(imageUrl: product.imageUrl),
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.shoppingCartPageTotal,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  curFormatter.format(shoppingCart.total),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ]);
  }
}

class _CartActions extends StatelessWidget {
  const _CartActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        AppButton.black(
          onPressed: () => context.pushNamed(AppRoutes.checkout),
          textStyle: Theme.of(context).textTheme.titleMedium,
          child: Text(l10n.shoppingCartPageCheckoutButton),
        ),
        const Gap(AppSpacing.lg),
        AppButton.outlinedWhite(
          onPressed: () => context.read<ShoppingCartCubit>().clear(),
          textStyle: Theme.of(context).textTheme.titleMedium,
          child: Text(l10n.shoppingCartPageClearCart),
        ),
      ],
    );
  }
}

class _CartListCard extends StatelessWidget {
  const _CartListCard({
    super.key,
    required this.items,
  });

  final List<ShoppingCartLineItem> items;

  @override
  Widget build(BuildContext context) {
    final curFormatter = NumberFormat.currency(symbol: 'R\$');

    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const Divider(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.product.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '${item.quantity}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(AppSpacing.md),
                    Text(
                      'X',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(AppSpacing.md),
                    Text(
                      curFormatter.format(item.product.price),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(AppSpacing.md),
                    Text(
                      '=',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const Gap(AppSpacing.md),
                    Text(
                      curFormatter.format(item.totalPrice),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]);
      },
    );
  }
}
