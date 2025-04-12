import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../product/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import 'cart_state.dart';

part 'cart_provider.g.dart';

@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  final _uuid = const Uuid();
  final List<CartItem> _cartItems = [];
  String? _appliedPromoCode;
  bool _isPromoCodeValid = false;

  @override
  CartState build() {
    return CartState(
      items: AsyncValue.data(_cartItems),
      total: AsyncValue.data(_calculateTotal()),
      discountedTotal: AsyncValue.data(_calculateDiscountedTotal()),
      appliedPromoCode: _appliedPromoCode,
      isPromoCodeValid: _isPromoCodeValid,
    );
  }

  double _calculateTotal() {
    return _cartItems.fold<double>(0, (sum, item) => sum + item.totalPrice);
  }

  double _calculateDiscountedTotal() {
    double total = 0.0;

    for (var item in _cartItems) {
      double itemPrice = item.product.price * item.quantity;

      if (item.product.discountPercentage != null &&
          item.product.discountPercentage! > 0) {
        double discount = item.product.discountPercentage!;
        itemPrice = itemPrice * (1 - discount);
      }

      if (_isPromoCodeValid &&
          item.product.promoCode == _appliedPromoCode &&
          item.product.promoCodeDiscount != null) {
        itemPrice = itemPrice * (1 - item.product.promoCodeDiscount!);
      }

      total += itemPrice;
    }

    return total;
  }

  void applyPromoCode(String promoCode) {
    var currentState = state;

    state = currentState.copyWith(items: const AsyncValue.loading());

    try {
      bool isValid = _cartItems.any(
        (item) =>
            item.product.promoCode == promoCode &&
            item.product.promoCodeDiscount != null &&
            item.product.promoCodeDiscount! > 0,
      );

      _appliedPromoCode = promoCode;
      _isPromoCodeValid = isValid;

      final subtotal = _calculateTotal();
      final discountedTotal = _calculateDiscountedTotal();
      state = CartState(
        items: AsyncValue.data(_cartItems),
        total: AsyncValue.data(subtotal),
        discountedTotal: AsyncValue.data(discountedTotal),
        appliedPromoCode: _appliedPromoCode,
        isPromoCodeValid: _isPromoCodeValid,
      );
    } catch (e, stackTrace) {
      state = currentState.copyWith(items: AsyncValue.error(e, stackTrace));
    }
  }

  void removePromoCode() {
    var currentState = state;

    state = currentState.copyWith(items: const AsyncValue.loading());

    try {
      _appliedPromoCode = null;
      _isPromoCodeValid = false;

      final subtotal = _calculateTotal();
      final discountedTotal = _calculateDiscountedTotal();
      state = CartState(
        items: AsyncValue.data(_cartItems),
        total: AsyncValue.data(subtotal),
        discountedTotal: AsyncValue.data(discountedTotal),
        appliedPromoCode: _appliedPromoCode,
        isPromoCodeValid: _isPromoCodeValid,
      );
    } catch (e, stackTrace) {
      state = currentState.copyWith(items: AsyncValue.error(e, stackTrace));
    }
  }

  void addProduct(Product product, {int quantity = 1}) {
    var currentState = state;

    state = currentState.copyWith(items: const AsyncValue.loading());

    try {
      final existingItemIndex = _cartItems.indexWhere(
        (cartItem) => cartItem.product.id == product.id,
      );

      if (existingItemIndex >= 0) {
        final existingItem = _cartItems[existingItemIndex];
        final updatedItem = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        );
        _cartItems[existingItemIndex] = updatedItem;
      } else {
        _cartItems.add(
          CartItem(id: _uuid.v4(), product: product, quantity: quantity),
        );
      }

      final subtotal = _calculateTotal();
      final discountedTotal = _calculateDiscountedTotal();
      state = CartState(
        items: AsyncValue.data(_cartItems),
        total: AsyncValue.data(subtotal),
        discountedTotal: AsyncValue.data(discountedTotal),
        appliedPromoCode: _appliedPromoCode,
        isPromoCodeValid: _isPromoCodeValid,
      );
    } catch (e, stackTrace) {
      state = currentState.copyWith(items: AsyncValue.error(e, stackTrace));
    }
  }

  void removeItem(String id) {
    var currentState = state;

    state = currentState.copyWith(items: const AsyncValue.loading());

    try {
      _cartItems.removeWhere((item) => item.id == id);

      final subtotal = _calculateTotal();
      final discountedTotal = _calculateDiscountedTotal();
      state = CartState(
        items: AsyncValue.data(_cartItems),
        total: AsyncValue.data(subtotal),
        discountedTotal: AsyncValue.data(discountedTotal),
        appliedPromoCode: _appliedPromoCode,
        isPromoCodeValid: _isPromoCodeValid,
      );
    } catch (e, stackTrace) {
      state = currentState.copyWith(items: AsyncValue.error(e, stackTrace));
    }
  }

  void updateCartItemQuantity(String id, int quantity) async {
    var currentState = state;

    state = currentState.copyWith(items: const AsyncValue.loading());

    try {
      if (quantity <= 0) {
        removeItem(id);
        return;
      }

      final index = _cartItems.indexWhere((cartItem) => cartItem.id == id);
      if (index >= 0) {
        final item = _cartItems[index];
        _cartItems[index] = item.copyWith(quantity: quantity);
      }

      final subtotal = _calculateTotal();
      final discountedTotal = _calculateDiscountedTotal();
      state = CartState(
        items: AsyncValue.data(_cartItems),
        total: AsyncValue.data(subtotal),
        discountedTotal: AsyncValue.data(discountedTotal),
        appliedPromoCode: _appliedPromoCode,
        isPromoCodeValid: _isPromoCodeValid,
      );
    } catch (e, stackTrace) {
      state = currentState.copyWith(items: AsyncValue.error(e, stackTrace));
    }
  }

  void clearCart() {
    var currentState = state;

    state = currentState.copyWith(items: const AsyncValue.loading());

    try {
      _cartItems.clear();
      _appliedPromoCode = null;
      _isPromoCodeValid = false;

      state = CartState(
        items: const AsyncValue.data([]),
        total: const AsyncValue.data(0.0),
        discountedTotal: const AsyncValue.data(0.0),
        appliedPromoCode: null,
        isPromoCodeValid: false,
      );
    } catch (e, stackTrace) {
      state = currentState.copyWith(items: AsyncValue.error(e, stackTrace));
    }
  }
}


