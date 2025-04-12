import 'package:ageno_flutter_assessment_skills/features/cart/presentation/widgets/quantity_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ageno_flutter_assessment_skills/features/cart/domain/entities/cart_item.dart';
import 'package:ageno_flutter_assessment_skills/features/cart/presentation/providers/cart_provider.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../../shared/presentation/widgets/image_error_builder.dart';

class CartItemWidget extends ConsumerWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appliedPromoCode = ref.watch(cartProvider).appliedPromoCode;
    final isPromoCodeValid = ref.watch(cartProvider).isPromoCodeValid;

    final priceInfo = _calculatePrices(
      item,
      appliedPromoCode,
      isPromoCodeValid,
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
        loadingBuilder: _imageLoadingBuilder,
        errorBuilder: (_, __, ___) => const ImageErrorBuilder(),
      ),
    );
  }

  Widget _imageLoadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;

    return SizedBox(
      width: 60,
      height: 60,
      child: Center(
        child: CircularProgressIndicator(
          value:
              loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Column _buildSubtitle(CartItem item, _PriceInfo priceInfo) {
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
          text(LocaleKeys.discount.tr(
          args: [(item.product.discountPercentage! * 100).toStringAsFixed(0)],
        ),),
        if (priceInfo.hasPromoDiscount)
          text(LocaleKeys.promoDiscount.tr(
            args: [(item.product.promoCodeDiscount! * 100).toStringAsFixed(0)],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceDisplay(_PriceInfo priceInfo) {
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

  _PriceInfo _calculatePrices(
    CartItem item,
    String? appliedPromoCode,
    bool isPromoCodeValid,
  ) {
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

    return _PriceInfo(
      regularPrice: regularPrice,
      discountedPrice: discountedPrice,
      totalRegularPrice: totalRegularPrice,
      totalDiscountedPrice: totalDiscountedPrice,
      hasDiscount: hasDiscount,
      hasPromoDiscount: hasPromoDiscount,
    );
  }
}

class _PriceInfo {
  final double regularPrice;
  final double discountedPrice;
  final double totalRegularPrice;
  final double totalDiscountedPrice;
  final bool hasDiscount;
  final bool hasPromoDiscount;

  const _PriceInfo({
    required this.regularPrice,
    required this.discountedPrice,
    required this.totalRegularPrice,
    required this.totalDiscountedPrice,
    required this.hasDiscount,
    required this.hasPromoDiscount,
  });
}
