import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../providers/cart_provider.dart';

class CartSummary extends ConsumerWidget {
  const CartSummary({
    super.key,
    required this.total,
    required this.discountedTotal,
  });

  final double total;
  final double discountedTotal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasDiscount = total > discountedTotal;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow:
            isLandscape
                ? null
                : [
                  BoxShadow(
                    color: Colors.grey.withAlpha(128),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
      ),
      child: Column(
        mainAxisAlignment:
            isLandscape ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(LocaleKeys.total.tr(), style: TextStyle(fontSize: 16)),
              Text(
                '${total.toStringAsFixed(2)} zł',
                style: TextStyle(
                  fontSize: 16,
                  decoration: hasDiscount ? TextDecoration.lineThrough : null,
                  color: hasDiscount ? Colors.grey : Colors.black,
                ),
              ),
            ],
          ),
          if (hasDiscount) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.afterDiscount.tr(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${discountedTotal.toStringAsFixed(2)} zł',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.youSave.tr(
                args: [(total - discountedTotal).toStringAsFixed(2)],
              ),
              style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.end,
            ),
          ],
          SizedBox(height: isLandscape ? 24 : 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(LocaleKeys.orderSuccess.tr()),
                  duration: const Duration(seconds: 2),
                ),
              );
              ref.read(cartProvider.notifier).clearCart();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              LocaleKeys.orderNow.tr(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
