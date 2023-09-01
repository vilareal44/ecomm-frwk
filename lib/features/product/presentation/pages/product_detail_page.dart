import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm/app/widgets/widgets.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/domain/usecases/get_product.dart';
import 'package:ecomm/features/product/presentation/bloc/bloc.dart';
import 'package:ecomm/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../widgets/add_to_cart.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  static Page page({required String productId}) =>
      MaterialPage<void>(child: ProductDetailPage(productId: productId));

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(
        getProductUseCase: sl.get<GetProductUseCase>(),
      )..load(productId: productId),
      child: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: ContainerLimited(
            child: ProductDetailView(),
          ),
        ),
      ),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.isLoading) return const _LoadingState();
        if (state.isFailure) return const _ProductFailedCard();
        if (state.isNotFound) return const _ProductNotFound();
        if (state.isSuccess) return _ProductDetailCard(product: state.product!);
        return Container();
      },
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ProductNotFound extends StatelessWidget {
  const _ProductNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('NotFound'),
    );
  }
}

class _ProductFailedCard extends StatelessWidget {
  const _ProductFailedCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Erro'),
    );
  }
}

class _ProductDetailCard extends StatelessWidget {
  const _ProductDetailCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    final curFormatter = NumberFormat.currency(symbol: 'R\$');

    return Column(
      children: [
        CachedNetworkImage(
          width: 300,
          height: 300,
          fit: BoxFit.contain,
          imageUrl: product.imageUrl,
          placeholder: (context, url) => const Center(
              child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ))),
          errorWidget: (context, url, error) => const Icon(
            Icons.error,
            size: 50,
          ),
        ),
        Text(
          product.name,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          curFormatter.format(product.price),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        AddToCartWidget(
          product: product,
        )
      ],
    );
  }
}
