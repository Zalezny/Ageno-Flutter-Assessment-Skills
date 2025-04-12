import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enums/category_type.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required double price,
    required String imageUrl,
    String? description,
    String? promoCode,
    double? promoCodeDiscount,
    double? discountPercentage,
    bool? isNew,
    String? brand,
    CategoryType? category,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}