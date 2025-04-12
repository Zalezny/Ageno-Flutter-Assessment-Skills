import 'package:ageno_flutter_assessment_skills/features/product/presentation/widgets/product_description.dart';
import 'package:ageno_flutter_assessment_skills/features/product/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/product.dart';

class ProductItem extends ConsumerWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProductImage(product: product, onAddToCart: (product, context) => _addToCart(product, ref, context)),
        ProductDescription(product: product),
      ],
    );
  }

  void _addToCart(Product product, WidgetRef ref, BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      //TODO: add to cart logic
      messenger.showSnackBar(SnackBar(content: Text('${product.name} dodany do koszyka'), duration: const Duration(seconds: 1)));
    } catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Błąd podczas dodawania do koszyka: $e'), backgroundColor: Colors.red, duration: const Duration(seconds: 2)),
      );
    }
  }
}
