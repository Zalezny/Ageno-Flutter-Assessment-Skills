class PriceInfo {
  final double regularPrice;
  final double discountedPrice;
  final double totalRegularPrice;
  final double totalDiscountedPrice;
  final bool hasDiscount;
  final bool hasPromoDiscount;

  const PriceInfo({
    required this.regularPrice,
    required this.discountedPrice,
    required this.totalRegularPrice,
    required this.totalDiscountedPrice,
    required this.hasDiscount,
    required this.hasPromoDiscount,
  });
}