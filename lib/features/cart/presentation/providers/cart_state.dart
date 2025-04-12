import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item.dart';

class CartState {
  final AsyncValue<List<CartItem>> items;
  final AsyncValue<double> total;
  final AsyncValue<double> discountedTotal;
  final String? appliedPromoCode;
  final bool isPromoCodeValid;

  CartState({
    this.items = const AsyncValue.loading(),
    this.total = const AsyncValue.loading(),
    this.discountedTotal = const AsyncValue.loading(),
    this.appliedPromoCode,
    this.isPromoCodeValid = false,
  });

  CartState copyWith({
    AsyncValue<List<CartItem>>? items,
    AsyncValue<double>? total,
    AsyncValue<double>? discountedTotal,
    String? appliedPromoCode,
    bool? isPromoCodeValid,
  }) {
    return CartState(
      items: items ?? this.items,
      total: total ?? this.total,
      discountedTotal: discountedTotal ?? this.discountedTotal,
      appliedPromoCode: appliedPromoCode ?? this.appliedPromoCode,
      isPromoCodeValid: isPromoCodeValid ?? this.isPromoCodeValid,
    );
  }
}