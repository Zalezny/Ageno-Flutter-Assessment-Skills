import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/enums/category_type.dart';
import '../../domain/entities/product.dart';
import '../screens/product_list_screen.dart';

class CategoryBar extends ConsumerWidget {
  final double height;
  final List<Product> products;
  const CategoryBar({super.key, required this.height, required this.products});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = products.map((product) => product.category).whereType<CategoryType>().toSet().toList();
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Container(
      color: Colors.white,
      height: height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          _buildCategoryItem(context, ref, CategoryType.all, isSelected: selectedCategory == null || selectedCategory == CategoryType.all),
          ...categories.map((category) => _buildCategoryItem(context, ref, category, isSelected: selectedCategory == category)),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, WidgetRef ref, CategoryType category, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedCategoryProvider.notifier).state = category == CategoryType.all ? null : category;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            category.label,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
        ),
      ),
    );
  }
}