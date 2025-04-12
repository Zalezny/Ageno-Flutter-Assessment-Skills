import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/injection.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_product_by_id.dart';
import '../../domain/usecases/get_products.dart';

final getProductsUseCaseProvider = Provider<GetProducts>((ref) {
  return getIt<GetProducts>();
});

final getProductByIdUseCaseProvider = Provider<GetProductById>((ref) {
  return getIt<GetProductById>();
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final getProductsUseCase = ref.watch(getProductsUseCaseProvider);
  return await getProductsUseCase();
});

final productProvider = FutureProvider.family<Product?, String>((ref, id) async {
  final getProductByIdUseCase = ref.watch(getProductByIdUseCaseProvider);
  return await getProductByIdUseCase(id);
});