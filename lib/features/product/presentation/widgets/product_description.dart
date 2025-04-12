import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/presentation/widgets/promo_badge.dart';
import '../../domain/entities/product.dart';

class ProductDescription extends ConsumerWidget {
  final Product product;

  const ProductDescription({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.brand != null) Text(product.brand!, style: Theme.of(context).textTheme.bodyMedium),
          Text(product.name, style: Theme.of(context).textTheme.titleMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          if (product.promoCodeDiscount != null && product.discountPercentage == null)
            PromoBadge(text: "${((1 - product.promoCodeDiscount!) * product.price).toStringAsFixed(2)} zł z kodem", color: Colors.black),
          if (product.discountPercentage == null)
            Text(
              '${product.price.toStringAsFixed(2)} zł',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            )
          else
            Text(
              '${((1 - product.discountPercentage!) * product.price).toStringAsFixed(2)} zł',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w800, color: Colors.red),
            ),
          const SizedBox(height: 8),
          if (product.discountPercentage != null) ...[
            Text('Najniższa cena w ciągu ostatnich 30 dni:', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
            Row(
              children: [
                Text(
                  "${product.price.toStringAsFixed(2)} zł",
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey, decoration: TextDecoration.lineThrough, decorationColor: Colors.grey),
                ),
                const SizedBox(width: 4),
                Text(
                  "${-(product.discountPercentage! * 100).toInt()}%",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
