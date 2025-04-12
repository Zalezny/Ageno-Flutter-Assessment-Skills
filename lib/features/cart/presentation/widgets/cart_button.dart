import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';

class CartButton extends ConsumerWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalAsync = ref.watch(cartProvider).total;
    final discountedTotalAsync = ref.watch(cartProvider).discountedTotal;
    final hasDiscount = _hasDiscount(totalAsync, discountedTotalAsync);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const CartScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Icon(
              Icons.shopping_cart_checkout,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 4),
            _buildPriceDisplay(
              context,
              totalAsync,
              discountedTotalAsync,
              hasDiscount,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceDisplay(
    BuildContext context,
    AsyncValue<double> totalAsync,
    AsyncValue<double> discountedTotalAsync,
    bool hasDiscount,
  ) {
    return discountedTotalAsync.when(
      data:
          (discountedTotal) => _buildTotalDisplay(
            context,
            totalAsync,
            discountedTotal,
            hasDiscount,
          ),
      loading:
          () => Text(
            "...",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
      error: (_, __) => _buildLoadingText(context),
    );
  }

  Widget _buildTotalDisplay(
    BuildContext context,
    AsyncValue<double> totalAsync,
    double discountedTotal,
    bool hasDiscount,
  ) {
    return totalAsync.when(
      data:
          (total) =>
              hasDiscount
                  ? _buildDiscountedPriceText(context, discountedTotal)
                  : _buildRegularPriceText(context, total),
      loading: () => _buildLoadingText(context),
      error: (_, __) => _buildLoadingText(context),
    );
  }

  Widget _buildDiscountedPriceText(BuildContext context, double price) {
    return Text(
      "${price.toStringAsFixed(2)}zł",
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRegularPriceText(BuildContext context, double price) {
    return Text(
      "${price.toStringAsFixed(2)}zł",
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildLoadingText(BuildContext context) {
    return Text(
      "0,00zł",
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  bool _hasDiscount(
    AsyncValue<double> totalAsync,
    AsyncValue<double> discountedTotalAsync,
  ) {
    if (totalAsync is AsyncData && discountedTotalAsync is AsyncData) {
      final total = totalAsync.value;
      final discountedTotal = discountedTotalAsync.value;
      if (total != null && discountedTotal != null) {
        return total > discountedTotal;
      }
    }
    return false;
  }
}
