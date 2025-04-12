import 'package:ageno_flutter_assessment_skills/features/cart/presentation/widgets/quantity_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ageno_flutter_assessment_skills/features/cart/domain/entities/cart_item.dart';
import 'package:ageno_flutter_assessment_skills/features/cart/presentation/providers/cart_provider.dart';
import 'package:ageno_flutter_assessment_skills/features/cart/presentation/providers/price_calculator_provider.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../shared/presentation/widgets/image_error_builder.dart';
import '../../../../shared/presentation/widgets/loading_image_builder.dart';
import '../../domain/entities/price_info.dart';

class CartItemWidget extends ConsumerWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appliedPromoCode = ref.watch(cartProvider).appliedPromoCode;
    final isPromoCodeValid = ref.watch(cartProvider).isPromoCodeValid;
    final priceCalculator = ref.watch(priceCalculatorProvider);

    final priceInfo = priceCalculator.calculatePrices(
      item: item,
      appliedPromoCode: appliedPromoCode,
      isPromoCodeValid: isPromoCodeValid,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              leading: _buildProductImage(item.product.imageUrl),
              title: Text(item.product.name),
              subtitle: _buildSubtitle(item, priceInfo),
              trailing: _buildPriceDisplay(priceInfo),
            ),
            QuantityControls(item: item),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: 60,
        height: 60,
        loadingBuilder:
            (_, child, loadingProgress) => LoadingImageBuilder(
              size: 60,
              loadingProgress: loadingProgress,
              child: child,
            ),
        errorBuilder: (_, __, ___) => const ImageErrorBuilder(),
      ),
    );
  }

  Column _buildSubtitle(CartItem item, PriceInfo priceInfo) {
    Widget text(String text) => Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.green, fontSize: 12),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(LocaleKeys.quantity.tr(args: [item.quantity.toString()])),
        if (priceInfo.hasDiscount)
          text(
            LocaleKeys.discount.tr(
              args: [
                (item.product.discountPercentage! * 100).toStringAsFixed(0),
              ],
            ),
          ),
        if (priceInfo.hasPromoDiscount)
          text(
            LocaleKeys.promoDiscount.tr(
              args: [
                (item.product.promoCodeDiscount! * 100).toStringAsFixed(0),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildPriceDisplay(PriceInfo priceInfo) {
    if (priceInfo.hasDiscount || priceInfo.hasPromoDiscount) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${priceInfo.totalRegularPrice.toStringAsFixed(2)} zł',
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            '${priceInfo.totalDiscountedPrice.toStringAsFixed(2)} zł',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.green,
            ),
          ),
        ],
      );
    }

    return Text(
      '${priceInfo.totalRegularPrice.toStringAsFixed(2)} zł',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}
