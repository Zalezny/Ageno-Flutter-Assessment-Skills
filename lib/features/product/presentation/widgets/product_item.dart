import 'package:ageno_flutter_assessment_skills/features/product/presentation/widgets/product_description.dart';
import 'package:ageno_flutter_assessment_skills/features/product/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../domain/entities/product.dart';

class ProductItem extends ConsumerWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImage(
          product: product,
          onAddToCart: (product, context) => _addToCart(product, ref, context),
        ),
        ProductDescription(product: product),
      ],
    );
  }

  void _addToCart(Product product, WidgetRef ref, BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      ref.read(cartProvider.notifier).addProduct(product);
      messenger.showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.itemAddedToCart.tr(args: [product.name])),
          duration: const Duration(seconds: 1),
        ),
      );
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.errorAddingToCart.tr(args: [e.toString()])),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
