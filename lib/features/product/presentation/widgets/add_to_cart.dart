import 'dart:math';

import 'package:ecomm/app/app.dart';
import 'package:ecomm/app/widgets/widgets.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/presentation/bloc/bloc.dart';
import 'package:ecomm/features/shopping_cart/presentation/bloc/bloc.dart';
import 'package:ecomm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'item_quantity_selector.dart';

/// A widget that shows an [ItemQuantitySelector] along with a [PrimaryButton]
/// to add the selected quantity of the item to the cart.
///

class AddToCartWidget extends StatelessWidget {
  const AddToCartWidget({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocBuilder<ProductCubit, ProductState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.productDetailPageQuantity),
              ItemQuantitySelector(
                quantity: state.quantity,
                onChanged: (qtd) =>
                    context.read<ProductCubit>().setQuantity(qtd),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          const Divider(),
          const Gap(AppSpacing.sm),
          AppButton.black(
            onPressed: () => context
                .read<ShoppingCartCubit>()
                .add(product: product, quantity: state.quantity),
            textStyle: Theme.of(context).textTheme.titleMedium,
            child: Text(l10n.productDetailPageAddToCartButton),
          )
        ],
      );
    });
  }
}
