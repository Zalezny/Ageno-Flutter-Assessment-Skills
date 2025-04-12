import 'package:ageno_flutter_assessment_skills/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/cart_item.dart';

class CartItemsList extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartItemsList({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        final item = cartItems[index];
        return CartItemWidget(key: ValueKey(item.id), item: item);
      },
    );
  }
}
