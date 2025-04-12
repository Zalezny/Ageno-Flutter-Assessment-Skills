import 'package:ageno_flutter_assessment_skills/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';

class CartClearButton extends ConsumerWidget {
  const CartClearButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCartItems = ref.watch(cartProvider).items;

    return asyncCartItems.when(
      data: (cartItems) {
        if (cartItems.isEmpty) return const SizedBox.shrink();
        return IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => _showClearCartDialog(context, ref),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  void _showClearCartDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(LocaleKeys.clearCartTitle.tr()),
            content: Text(LocaleKeys.clearCartConfirm.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text(LocaleKeys.cancel.tr()),
              ),
              TextButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).clearCart();
                  Navigator.of(ctx).pop();
                },
                child: Text(LocaleKeys.clear.tr()),
              ),
            ],
          ),
    );
  }
}
