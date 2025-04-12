import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ageno_flutter_assessment_skills/features/cart/domain/services/price_calculator_service.dart';

final priceCalculatorProvider = Provider<PriceCalculatorService>((ref) {
  return PriceCalculatorService();
});
