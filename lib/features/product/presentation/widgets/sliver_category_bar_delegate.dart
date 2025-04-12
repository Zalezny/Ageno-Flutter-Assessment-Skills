import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';
import 'category_bar.dart';

class SliverCategoryBarDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final List<Product> products;
  SliverCategoryBarDelegate({required this.height, required this.products});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return CategoryBar(height: height, products: products);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate is SliverCategoryBarDelegate && (oldDelegate.height != height || oldDelegate.products != products);
  }
}