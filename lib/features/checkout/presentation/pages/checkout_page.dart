import 'dart:async';

import 'package:ecomm/app/constants/constants.dart';
import 'package:ecomm/features/shopping_cart/domain/entities/entities.dart';
import 'package:ecomm/features/shopping_cart/presentation/bloc/bloc.dart';
import 'package:ecomm/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  static Page page() => const MaterialPage<void>(child: CheckoutPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const CheckoutView(),
    );
  }
}

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  Future<Uint8List> _makePdf(
      BuildContext context, ShoppingCart shoppingCart) async {
    final pdf = pw.Document();
    final l10n = context.l10n;
    final curFormatter = NumberFormat.currency(symbol: 'R\$');

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(text: l10n.shoppingCartPageTitle),
                pw.Column(
                  children: shoppingCart.lineItems.map((item) {
                    return pw.Row(children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              item.product.name,
                            ),
                          ],
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          children: [
                            pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Text(
                                  '${item.quantity}',
                                ),
                                pw.SizedBox(width: AppSpacing.md),
                                pw.Text(
                                  'x',
                                ),
                                pw.SizedBox(width: AppSpacing.md),
                                pw.Text(
                                  curFormatter.format(item.product.price),
                                ),
                                pw.SizedBox(width: AppSpacing.md),
                                pw.Text(
                                  '=',
                                ),
                                pw.SizedBox(width: AppSpacing.md),
                                pw.Text(
                                  curFormatter.format(item.totalPrice),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.Row(
                    // leading: CachedNetworkImage(imageUrl: product.imageUrl),
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              l10n.shoppingCartPageTotal,
                            ),
                          ],
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(
                              curFormatter.format(shoppingCart.total),
                            ),
                          ],
                        ),
                      ),
                    ])
              ]);
        },
      ),
    );
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final shoppingCartCubit = context.read<ShoppingCartCubit>();
      final shoppingCart = shoppingCartCubit.state.shoppingCart;

      unawaited(shoppingCartCubit.clear());

      return PdfPreview(
        build: (_) => _makePdf(context, shoppingCart!),
      );
    });
  }
}
