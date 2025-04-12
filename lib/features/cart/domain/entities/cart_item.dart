import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../product/domain/entities/product.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
abstract class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String id,
    required Product product,
    required int quantity,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  double get totalPrice => product.price * quantity;
}
