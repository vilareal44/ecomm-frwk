import 'package:ecomm/app/app.dart';
import 'package:ecomm/features/product/domain/usecases/find_all_products.dart';
import 'package:ecomm/features/product/domain/usecases/search_product.dart';
import 'package:ecomm/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm/app/widgets/widgets.dart';
import 'package:ecomm/features/product/domain/entities/entities.dart';
import 'package:ecomm/features/product/domain/usecases/get_product.dart';
import 'package:ecomm/features/product/presentation/bloc/bloc.dart';
import 'package:ecomm/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../bloc/bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static Page page() => const MaterialPage<void>(child: SearchPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(
        searchProductUseCase: sl.get<SearchProductUseCase>(),
        findAllProductsUseCase: sl.get<FindAllProductsUseCase>(),
      )..add(const FindAllRequested()),
      child: Scaffold(
        appBar: AppBar(),
        body: const SafeArea(
          child: ContainerLimited(
            child: SearchView(),
          ),
        ),
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        AppTextField(
          // readOnly: state.status.isInProgress,
          hintText: l10n.searchPageTypeSearchQueryMessage,
          onChanged: (query) =>
              context.read<SearchBloc>().add(SearchQueryChanged(query)),
        ),
        const Gap(AppSpacing.xlg),
        const SearchResultView(),
      ],
    );
  }
}

class SearchResultView extends StatelessWidget {
  const SearchResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.isLoading) return const _LoadingState();
        if (state.isFailure) return const _ProductsFailedCard();
        if (state.isNotFound) return const _ProductsNotFound();
        if (state.isSuccess) {
          return _SearchResultListCard(products: state.products!);
        }
        if (state.isInitial) return const _ProductsInitial();
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

class _ProductsNotFound extends StatelessWidget {
  const _ProductsNotFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Text(l10n.searchPageNoProductFoundMessage),
    );
  }
}

class _ProductsInitial extends StatelessWidget {
  const _ProductsInitial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Text(l10n.searchPageTypeSearchQueryMessage),
    );
  }
}

class _ProductsFailedCard extends StatelessWidget {
  const _ProductsFailedCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Center(
      child: Text(l10n.searchPageOperationFaileMessage),
    );
  }
}

class _SearchResultListCard extends StatelessWidget {
  const _SearchResultListCard({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final curFormatter = NumberFormat.currency(symbol: 'R\$');

    return ListView.builder(
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return InkWell(
          onTap: () =>
              context.pushNamed(AppRoutes.productDetails, pathParameters: {
            'productId': product.id,
          }),
          child: ListTile(
            leading: ListImage(imageUrl: product.imageUrl),
            title: Text(product.name),
            subtitle: Text(curFormatter.format(product.price)),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
    );
  }
}

class ListImage extends StatelessWidget {
  const ListImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: 70,
      height: 70,
      fit: BoxFit.contain,
      imageUrl: imageUrl,
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
    );
  }
}
