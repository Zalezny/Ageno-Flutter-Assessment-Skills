import 'package:ageno_flutter_assessment_skills/features/cart/domain/entities/cart_item.dart';
import 'package:ageno_flutter_assessment_skills/features/cart/domain/entities/price_info.dart';

class PriceCalculatorService {
  /// Kalkuluje informacje o cenach dla danego produktu w koszyku
  PriceInfo calculatePrices({
    required CartItem item,
    required String? appliedPromoCode,
    required bool isPromoCodeValid,
  }) {
    final regularPrice = item.product.price;
    final hasDiscount =
        item.product.discountPercentage != null &&
        item.product.discountPercentage! > 0;
    final hasPromoDiscount =
        isPromoCodeValid &&
        item.product.promoCode == appliedPromoCode &&
        item.product.promoCodeDiscount != null;

    double discountedPrice = regularPrice;

    if (hasDiscount) {
      discountedPrice = regularPrice * (1 - item.product.discountPercentage!);
    }

    if (hasPromoDiscount) {
      discountedPrice = discountedPrice * (1 - item.product.promoCodeDiscount!);
    }

    final totalRegularPrice = regularPrice * item.quantity;
    final totalDiscountedPrice = discountedPrice * item.quantity;

    return PriceInfo(
      regularPrice: regularPrice,
      discountedPrice: discountedPrice,
      totalRegularPrice: totalRegularPrice,
      totalDiscountedPrice: totalDiscountedPrice,
      hasDiscount: hasDiscount,
      hasPromoDiscount: hasPromoDiscount,
    );
  }
}
