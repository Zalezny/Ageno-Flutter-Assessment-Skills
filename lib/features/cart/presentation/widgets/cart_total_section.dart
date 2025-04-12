import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../providers/cart_provider.dart';
import 'cart_summary.dart';

class CartTotalSection extends ConsumerWidget {
  final bool useCenter;

  const CartTotalSection({super.key, this.useCenter = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCartTotal = ref.watch(cartProvider).total;
    final asyncDiscountedTotal = ref.watch(cartProvider).discountedTotal;

    Widget buildLoading() =>
        useCenter
            ? const Center(child: CircularProgressIndicator())
            : const CircularProgressIndicator();

    Widget buildError() =>
        useCenter
            ? Center(child: Text(LocaleKeys.cartTotal.tr()))
            : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(LocaleKeys.cartTotal.tr()),
            );

    return asyncCartTotal.when(
      data:
          (total) => asyncDiscountedTotal.when(
            data:
                (discountedTotal) =>
                    CartSummary(total: total, discountedTotal: discountedTotal),
            loading: () => buildLoading(),
            error: (_, __) => buildError(),
          ),
      loading: () => buildLoading(),
      error: (_, __) => buildError(),
    );
  }
}
