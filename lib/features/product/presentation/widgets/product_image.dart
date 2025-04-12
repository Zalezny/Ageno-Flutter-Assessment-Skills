import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/promo_badge.dart';
import '../../domain/entities/product.dart';

class ProductImage extends StatelessWidget {
  final Product product;
  final void Function(Product, BuildContext) onAddToCart;
  const ProductImage({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Stack(
        children: [
          _buildImageContainer(context),
          _buildShoppingBasketButton(context),
          _buildPromoBadges(context),
        ],
      ),
    );
  }

  Widget _buildImageContainer(BuildContext context) {
    return _replaceWhiteBackground(
      listofcolors: [const Color(0xffe9e6e1), const Color(0xffe9e6e1)],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: Alignment.center,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Icon(Icons.error_outline, color: Colors.red, size: 40),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingBasketButton(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        height: 36,
        width: 36,
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () => onAddToCart(product, context),
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.shopping_basket_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBadges(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 8),
        child: Wrap(
          runSpacing: 4,
          children: [
            if (product.promoCode != null)
              PromoBadge(text: product.promoCode!, color: Colors.black),
            if (product.isNew == true)
              PromoBadge(text: 'Nowość', color: Colors.blue.shade900),
            if (product.discountPercentage != null)
              PromoBadge(
                text: _getPromoDiscount(product.discountPercentage!),
                color: Colors.red,
              ),
          ],
        ),
      ),
    );
  }

  String _getPromoDiscount(double promoDiscount) {
    return '-${(promoDiscount * 100).toInt()}%';
  }

  Widget _replaceWhiteBackground({
    required Widget child,
    required List<Color> listofcolors,
  }) {
    return ShaderMask(
      child: child,
      shaderCallback: (Rect bounds) {
        return LinearGradient(colors: listofcolors).createShader(bounds);
      },
    );
  }
}
