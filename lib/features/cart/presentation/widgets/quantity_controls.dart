import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item.dart';
import '../providers/cart_provider.dart';

class QuantityControls extends ConsumerWidget {
  final CartItem item;
  const QuantityControls({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => _updateQuantity(ref, item.quantity - 1),
        ),
        Text(
          '${item.quantity}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _updateQuantity(ref, item.quantity + 1),
        ),
      ],
    );
  }

  void _updateQuantity(WidgetRef ref, int newQuantity) {
    ref
        .read(cartProvider.notifier)
        .updateCartItemQuantity(item.id, newQuantity);
  }
}
